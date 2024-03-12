-- populate users
DELETE
FROM USERS;
insert into USERS (ID, EMAIL, PASSWORD, FIRST_NAME, LAST_NAME, DISPLAY_NAME)
values (1, 'user@gmail.com', '{noop}password', 'userFirstName', 'userLastName', 'userDisplayName'),
       (2, 'admin@gmail.com', '{noop}admin', 'adminFirstName', 'adminLastName', 'adminDisplayName'),
       (3, 'guest@gmail.com', '{noop}guest', 'guestFirstName', 'guestLastName', 'guestDisplayName'),
       (4, 'manager@gmail.com', '{noop}manager', 'managerFirstName', 'managerLastName', 'managerDisplayName'),
       (5, 'taras@gmail.com', '{noop}password', 'Тарас', 'Шевченко', '@taras'),
       (6, 'petlura@gmail.com', '{noop}password', 'Симон', 'Петлюра', '@epetl'),
       (7, 'moroz_a@gmail.com', '{noop}password', 'Александр', 'Мороз', '@Moroz93'),
       (8, 'antonio.nest@gmail.com', '{noop}password', 'Антон', 'Нестеров', '@antonio_nest'),
       (9, 'i.franko@gmail.com', '{noop}password', 'Иван', 'Франко', '@ifranko'),
       (10, 'g.skovoroda@gmail.com', '{noop}password', 'Григорий', 'Сковорода', '@Gregory24'),
       (11, 'arsh.and@gmail.com', '{noop}password', 'Андрей', 'Арш', '@arsh01'),
       (12, 'squirrel2011@gmail.com', '{noop}password', 'Леся', 'Иванюк', '@SmallSquirrel'),
       (13, 'nikk24@gmail.com', '{noop}password', 'Николай', 'Никулин', '@nikk'),
       (14, 'artem711@gmail.com', '{noop}password', 'Артем', 'Запорожец', '@Artt'),
       (15, 'max.pain@gmail.com', '{noop}password', 'Максим', 'Дудник', '@MaxPain'),
       (16, 'admin@aws.co', '{noop}password', 'test', 'admin', '@testAdmin');

-- 0 DEV
-- 1 ADMIN
-- 2 MANAGER
DELETE
FROM USER_ROLE;
insert into USER_ROLE (USER_ID, ROLE)
values (1, 0),
       (2, 0),
       (2, 1),
       (4, 2),
       (5, 0),
       (6, 0),
       (7, 0),
       (8, 0),
       (9, 0),
       (10, 0),
       (11, 0),
       (12, 0),
       (13, 0),
       (14, 0),
       (15, 1),
       (16, 1);


insert into PROFILE (ID, LAST_FAILED_LOGIN, LAST_LOGIN, MAIL_NOTIFICATIONS)
values (1, null, null, 49),
       (2, null, null, 14);
ALTER TABLE CONTACT ALTER COLUMN "VALUE" RENAME TO CONTACT_VALUES;

insert into CONTACT (ID, CODE, CONTACT_VALUES)
values (1, 'skype', 'userSkype'),
       (1, 'mobile', '+01234567890'),
       (1, 'website', 'user.com'),
       (2, 'github', 'adminGitHub'),
       (2, 'tg', 'adminTg'),
       (2, 'vk', 'adminVk');

delete
from ATTACHMENT;

insert into ATTACHMENT (ID, name, file_link, object_id, object_type, user_id, date_time)
values (1, 'Снимок экрана 1.png', './attachments/project/1_Снимок экрана 1.png', 2, 0, 4, '2023-05-04 22:28:50.215429'),
       (2, 'Снимок экрана 2.png', './attachments/project/2_Снимок экрана 2.png', 2, 0, 4, '2023-05-04 22:28:53.687600'),
       (3, 'Ежедневный-чеклист.xlsx', './attachments/project/3_Ежедневный-чеклист.xlsx', 2, 0, 4,
        '2023-05-04 22:31:15.166547'),
       (4, 'Снимок экрана 1.png', './attachments/task/1_Снимок экрана 1.png', 41, 2, 4, '2023-05-04 22:28:53.687600'),
       (5, 'Снимок экрана 2.png', './attachments/task/2_Снимок экрана 2.png', 41, 2, 4, '2023-05-04 22:28:50.215429'),
       (6, 'Ежедневный-чеклист.xlsx', './attachments/task/3_Ежедневный-чеклист.xlsx', 38, 2, 4,
        '2023-05-04 22:28:50.215429');

-- populate tasks
delete
from TASK;
delete
from SPRINT;
delete
from PROJECT;
delete
from ACTIVITY;


insert into PROJECT (ID, code, title, description, type_code, parent_id)
values (1, 'JiraRush', 'JiraRush', '«Mini-JIRA» app : project management system tutorial app', 'task_tracker', null),
       (2, 'Test_Project', 'Test Project', 'Just test project', 'task_tracker', null),
       (3, 'Test_Project_2', 'Test Project 2', 'Just test project 2', 'task_tracker', null),
       (4, 'JiraRush sub', 'JiraRush subproject', 'subproject', 'task_tracker', 1);


insert into SPRINT (ID, status_code, startpoint, endpoint, code, project_id)
values (1, 'active', null, null, 'Sprint-2', 1),
       (2, 'finished', '2023-04-09 08:05:10', '2023-04-29 16:48:34', 'Sprint-1', 2),
       (3, 'finished', '2023-04-03 12:14:11', '2023-04-18 17:03:41', 'Sprint-2', 2),
       (4, 'active', '2023-04-05 14:25:43', '2023-06-10 13:00:00', 'Sprint-3', 2),
       (5, 'active', null, null, 'Sprint-1', 4);


---- project 1 -------------
INSERT INTO TASK (ID, TITLE, TYPE_CODE, STATUS_CODE, PROJECT_ID, SPRINT_ID, STARTPOINT)
values (1, 'Data', 'epic', 'in_progress', 1, 1, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (2, 'Trees', 'epic', 'in_progress', 1, 1, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (3, 'UI', 'epic', 'in_progress', 1, 1, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (4, 'Sprint', 'epic', 'in_progress', 1, 1, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (5, 'Project', 'epic', 'in_progress', 1, 1, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (6, 'Task', 'epic', 'in_progress', 1, 1, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (7, 'Attachments', 'story', 'in_progress', 1, 1,now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (8, 'Dashboard', 'epic', 'in_progress', 1, 1, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (9, 'Report of Sprint (UI)', 'story', 'in_progress', 1, 1, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (10, 'Organizational-architectural', 'epic', 'in_progress', 1, 1, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND), ---- project 2 -------------
       (11, 'Title', 'task', 'todo', 2, 2, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (12, 'Title', 'task', 'todo', 2, 2, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (13, 'Title', 'task', 'in_progress', 2, 2, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (14, 'Title', 'task', 'in_progress', 2, 2, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (15, 'Title', 'task', 'in_progress', 2, 2, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (16, 'Title', 'task', 'test', 2, 2, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (17, 'Title', 'task', 'done', 2, 2, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (18, 'Title', 'task', 'done', 2, 2, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (19, 'Title', 'task', 'canceled', 2, 2, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (20, 'Title', 'task', 'ready_for_test', 2, 2, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (21, 'Title', 'task', 'in_progress', 2, 3, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (22, 'Title', 'task', 'in_progress', 2, 3, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (23, 'Title', 'task', 'in_progress', 2, 3, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (24, 'Title', 'task', 'test', 2, 3, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (25, 'Title', 'task', 'test', 2, 3, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (26, 'Title', 'task', 'test', 2, 3, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (27, 'Title', 'task', 'done', 2, 3, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (28, 'Title', 'task', 'done', 2, 3, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (29, 'Title', 'task', 'ready_for_test', 2, 3, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (30, 'Title', 'task', 'ready_for_test', 2, 3,now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (31, 'Title', 'task', 'todo', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (32, 'Title', 'story', 'todo', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (33, 'Title', 'bug', 'todo', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (34, 'Title', 'task', 'todo', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (35, 'Title', 'task', 'todo', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (36, 'Title', 'epic', 'in_progress', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (37, 'Title', 'task', 'ready_for_review', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (38, 'Title', 'task', 'ready_for_review', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (39, 'Title', 'story', 'ready_for_test', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (40, 'Title', 'task', 'review', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (41, 'Title', 'bug', 'review', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (42, 'Title', 'task', 'test', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (43, 'Title', 'epic', 'test', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (44, 'Title', 'task', 'done', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (45, 'Title', 'task', 'done', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (46, 'Title', 'story', 'done', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (47, 'Title', 'bug', 'done', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (48, 'Title', 'task', 'canceled', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (49, 'Title', 'task', 'todo', 2, 2, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (50, 'Title', 'task', 'todo', 2, 2, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (51, 'Title', 'task', 'in_progress', 2, 2, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (52, 'Title', 'task', 'in_progress', 2, 2, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (53, 'Title', 'task', 'in_progress', 2, 2, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (54, 'Title', 'task', 'test', 2, 2, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (55,'Title', 'task', 'done', 2, 2, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (56,'Title', 'task', 'done', 2, 2, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (57, 'Title', 'task', 'canceled', 2, 2, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (58, 'Title', 'task', 'ready_for_test', 2, 2, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (59, 'Title', 'task', 'in_progress', 2, 3, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (60, 'Title', 'task', 'in_progress', 2, 3, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (61, 'Title', 'task', 'in_progress', 2, 3, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (62, 'Title', 'task', 'test', 2, 3, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (63, 'Title', 'task', 'test', 2, 3, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (64, 'Title', 'task', 'test', 2, 3, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (65, 'Title', 'task', 'done', 2, 3, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (66, 'Title', 'task', 'done', 2, 3, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (67, 'Title', 'task', 'ready_for_test', 2, 3, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (68, 'Title', 'task', 'ready_for_test', 2, 3, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (69, 'Title', 'task', 'todo', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (70, 'Title', 'story', 'todo', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (71, 'Title', 'bug', 'todo', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (72, 'Title', 'task', 'todo', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (73,'Title', 'task', 'todo', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (74, 'Title', 'epic', 'in_progress', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (75,'Title', 'task', 'ready_for_review', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (76,'Title', 'task', 'ready_for_review', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (77,'Title', 'story', 'ready_for_test', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (78,'Title', 'task', 'review', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (79,'Title', 'bug', 'review', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (80,'Title', 'task', 'test', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (81,'Title', 'epic', 'test', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (82,'Title', 'task', 'done', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (83,'Title', 'task', 'done', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (84,'Title', 'story', 'done', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (85,'Title', 'bug', 'done', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (86,'Title', 'task', 'canceled', 2, 4, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (87,'subproject sprint task', 'epic', 'in_progress', 4, 5, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (88,'subproject backlog task', 'epic', 'in_progress', 4, null, now() + random() * interval '5' MINUTE + random() * interval '20' SECOND);

INSERT INTO TASK (ID, TITLE, TYPE_CODE, STATUS_CODE, PROJECT_ID, SPRINT_ID, PARENT_ID, STARTPOINT)
values (89, 'Add role manager and filters in security', 'task', 'done', 1, 1, 1,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (90, 'Add users from task-timing', 'task', 'ready_for_review', 1, 1, 1,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (91, 'Add tasks-2 in DB', 'task', 'in_progress', 1, 1, 1,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (92, 'Remove reference with USER_TYPE IN (3,4,5)', 'task', 'in_progress', 1, 1, 1,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (93, 'REST API for trees', 'task', 'in_progress', 1, 1, 2,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (94, 'Drawing in trees', 'task', 'in_progress', 1, 1, 2,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (95, 'Context menu', 'task', 'in_progress', 1, 1, 2,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (96, 'Reassignment sprint', 'task', 'in_progress', 1, 1, 2,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (97, 'Add task, subtask, sprint, subsprint', 'task', 'in_progress', 1, 1, 2,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (98, 'Make layout for view TitleTo', 'task', 'in_progress', 1, 1, 3,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (99, 'Make layout for edit TitleTo', 'task', 'in_progress', 1, 1, 3,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (100, 'Fix header-fragment', 'task', 'ready_for_review', 1, 1, 3,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (101, 'REST API', 'task', 'in_progress', 1, 1, 4,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (102, 'Tests', 'task', 'in_progress', 1, 1, 4,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (103, 'UI view, mock button to dashboard', 'task', 'in_progress', 1, 1, 4,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (104, 'UI edit', 'task', 'in_progress', 1, 1, 4,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (105, 'REST API', 'task', 'in_progress', 1, 1, 5,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (106, 'Tests', 'task', 'in_progress', 1, 1, 5,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (107, 'UI view, mock button to dashboard', 'task', 'in_progress', 1, 1, 5,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (108, 'UI edit', 'task', 'in_progress', 1, 1, 5,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (109, 'REST API', 'task', 'in_progress', 1, 1, 6,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (110, 'Tests', 'task', 'in_progress', 1, 1, 6,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (111, 'UI view, mock button to dashboard', 'task', 'in_progress', 1, 1, 6,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (112, 'UI edit', 'task', 'in_progress', 1, 1, 6,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (113, 'UI view add to Task, mock button to dashboard', 'task', 'in_progress', 1, 1, 6,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (114, 'UI edit add to Task', 'task', 'in_progress', 1, 1, 6,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (115, 'Edit changelog with changes of Task model', 'task', 'in_progress', 1, 1, 6,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (116, 'REST API: changeStatus', 'task', 'in_progress', 1, 1, 6,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (117, 'Make columns with tasks', 'task', 'in_progress', 1, 1, 8,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (118, 'UI tab of tasks', 'task', 'in_progress', 1, 1, 8,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (119, 'Context mune', 'task', 'in_progress', 1, 1, 8,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (120, 'Duration, count of tasks, elapsed time', 'task', 'in_progress', 1, 1, 9,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (121, 'Meeting, dividing tasks', 'task', 'in_progress', 1, 1, 10,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (122, 'Refactoring packages', 'task', 'in_progress', 1, 1, 10,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (123, 'Refactoring tasks', 'task', 'in_progress', 1, 1, 10,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (124, 'Subproject sprint subtask', 'task', 'in_progress', 4, 5, 87,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND),
       (125, 'Subproject backlog subtask', 'task', 'in_progress', 4, null, 88,
        now() + random() * interval '5' MINUTE + random() * interval '20' SECOND);


---task 1------
INSERT INTO ACTIVITY(ID, AUTHOR_ID, TASK_ID, UPDATED, COMMENT, TITLE, DESCRIPTION, ESTIMATE, TYPE_CODE, STATUS_CODE,
                     PRIORITY_CODE)
values (1, 6, 1, '2023-05-15 09:05:10', null, 'Data', null, 3, 'epic', 'in_progress', 'low'),
       (2, 5, 1, '2023-05-15 12:25:10', null, 'Data', null, null, null, null, 'normal'),
       (3, 6, 1, '2023-05-15 14:05:10', null, 'Data', null, 4, null, null, null), ---task 118----
       (4, 11, 118, '2023-05-16 10:05:10', null, 'UI tab of tasks', null, 4, 'task', 'in_progress', 'normal'),
       (5, 5, 118, '2023-05-16 11:10:10', null, 'UI tab of tasks', null, null, null, null, 'high'),
       (6, 11, 118, '2023-05-16 12:30:10', null, 'UI tab of tasks', null, 2, null, null, null);

