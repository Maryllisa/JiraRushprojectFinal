package com.javarush.jira.profile.internal.web;

import com.javarush.jira.login.AuthUser;
import com.javarush.jira.login.Role;
import com.javarush.jira.login.User;
import com.javarush.jira.profile.ProfileTo;
import com.javarush.jira.profile.internal.ProfileMapper;
import com.javarush.jira.profile.internal.ProfileRepository;
import com.javarush.jira.profile.internal.model.Profile;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.core.Authentication;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.util.HashSet;

import static org.junit.Assert.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.Mockito.*;
import static org.springframework.security.oauth2.core.oidc.OidcScopes.EMAIL;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.user;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;


@SpringBootTest
@AutoConfigureMockMvc
public class ProfileRestControllerTest {

    @Autowired
    private MockMvc mockMvc;
    @Mock
    private AuthUser authUser;
    @Mock
    private Authentication authentication;
    @Mock
    ProfileRepository profileRepositoryMock;
    @Mock
    ProfileMapper profileMapperMock;
    @InjectMocks
    private ProfileRestController profileRestController;
    private User users;

    @BeforeEach
    public void init() {
        MockMvcBuilders.standaloneSetup(profileRestController)
                .defaultRequest(get("/api/profile").principal(authentication))
                .build();
        users = new User(123L, "john@example.com",
                "password123",
                "John",
                "Doe",
                "JohnD",
                Role.MANAGER);
    }

    @Test
    public void getUnauthorized() throws Exception {
        mockMvc.perform(get("/api/profile")
                        .param("email", EMAIL))
                .andExpect(status().isUnauthorized());
    }

    @Test
    public void getAuthorized() throws Exception {

        when(authentication.getPrincipal()).thenReturn(users);
        when(authUser.id()).thenReturn(123L);
        mockMvc.perform(MockMvcRequestBuilders.get("/api/profile").with(user(new AuthUser(users))))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").value(123L));
    }

    @Test
    public void updateSuccess() {

        ProfileTo profileTo = new ProfileTo(123L, new HashSet<>(), new HashSet<>());
        long id = 123L;

        when(profileRepositoryMock.getOrCreate(anyLong())).thenReturn(new Profile());
        when(profileMapperMock.updateFromTo(any(Profile.class), any(ProfileTo.class))).thenReturn(new Profile());


        profileRestController.update(profileTo, id);

        verify(profileRepositoryMock).getOrCreate(anyLong());
        verify(profileMapperMock).updateFromTo(any(Profile.class), any(ProfileTo.class));
        verify(profileRepositoryMock).save(any(Profile.class));
    }

    @Test()
    public void updateFailure() {
        // Создаем экземпляры объектов, необходимых для теста
        ProfileTo profileTo = new ProfileTo(123L, new HashSet<>(), new HashSet<>());
        long id = 123L;

        doThrow(new IllegalArgumentException()).when(profileRepositoryMock).save(null);
        when(profileRepositoryMock.getOrCreate(anyLong())).thenReturn(null);

        assertThrows(IllegalArgumentException.class, () -> {
            profileRestController.update(profileTo, id);
        });
    }

}

