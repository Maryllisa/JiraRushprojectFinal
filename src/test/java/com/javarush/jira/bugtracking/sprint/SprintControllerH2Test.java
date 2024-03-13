package com.javarush.jira.bugtracking.sprint;

import com.javarush.jira.bugtracking.Handlers;
import com.javarush.jira.bugtracking.project.ProjectRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Profile;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;
@ExtendWith(MockitoExtension.class)
@Profile("H2")
class SprintControllerH2Test {

    @Mock
    private SprintRepository sprintRepository;
    @Mock
    private ProjectRepository projectRepository;
    @Mock
    private Handlers.SprintHandler handler;
    private SprintMapper sprintMapper;

    @InjectMocks
    private SprintController sprintController;

    private Long projectId;
    private String statusCode;

    @BeforeEach
    public void setup() {

        projectId = 1L;
        statusCode = "active";
        handler = new Handlers.SprintHandler(sprintRepository, sprintMapper);
        sprintController = new SprintController(projectRepository, handler);

    }

    @Test
    public void testGetAllByProjectAndStatus() {
        List<Sprint> expectedSprints = Arrays.asList(
                new Sprint(1L, "1", "active", 1L),
                new Sprint(4L, "2", "active", 2L));

        when(sprintRepository.getAllByProjectAndStatus(eq(projectId), eq(statusCode)))
                .thenReturn(expectedSprints);

        List<Sprint> actualSprints = sprintController.getAllByProjectAndStatus(projectId, statusCode);
        assertEquals(expectedSprints.size(), actualSprints.size());
        for (int i = 0; i < expectedSprints.size(); i++) {
            assertEquals(expectedSprints.get(0).getId(), actualSprints.get(0).getId());
            assertEquals(expectedSprints.get(0).getCode(), actualSprints.get(0).getCode());
            assertEquals(expectedSprints.get(0).getStatusCode(), actualSprints.get(0).getStatusCode());
            assertEquals(expectedSprints.get(0).getProjectId(), actualSprints.get(0).getProjectId());
        }
    }
}