--liquibase formatted sql

--changeset kmpk:init_schema
DROP TABLE IF EXISTS USER_ROLE;
DROP TABLE IF EXISTS CONTACT;
DROP TABLE IF EXISTS MAIL_CASE;
DROP
SEQUENCE IF EXISTS MAIL_CASE_ID_SEQ;
DROP TABLE IF EXISTS PROFILE;
DROP TABLE IF EXISTS TASK_TAG;
DROP TABLE IF EXISTS USER_BELONG;
DROP
SEQUENCE IF EXISTS USER_BELONG_ID_SEQ;
DROP TABLE IF EXISTS ACTIVITY;
DROP
SEQUENCE IF EXISTS ACTIVITY_ID_SEQ;
DROP TABLE IF EXISTS TASK;
DROP
SEQUENCE IF EXISTS TASK_ID_SEQ;
DROP TABLE IF EXISTS SPRINT;
DROP
SEQUENCE IF EXISTS SPRINT_ID_SEQ;
DROP TABLE IF EXISTS PROJECT;
DROP
SEQUENCE IF EXISTS PROJECT_ID_SEQ;
DROP TABLE IF EXISTS REFERENCE;
DROP
SEQUENCE IF EXISTS REFERENCE_ID_SEQ;
DROP TABLE IF EXISTS ATTACHMENT;
DROP
SEQUENCE IF EXISTS ATTACHMENT_ID_SEQ;
DROP TABLE IF EXISTS USERS;
DROP
SEQUENCE IF EXISTS USERS_ID_SEQ;

create table PROJECT
(
    ID bigint primary key,
    CODE        varchar(32)   not null
        constraint UK_PROJECT_CODE unique,
    TITLE       varchar(1024) not null,
    DESCRIPTION varchar(4096) not null,
    TYPE_CODE   varchar(32)   not null,
    STARTPOINT  timestamp,
    ENDPOINT    timestamp,
    PARENT_ID   bigint,
    constraint FK_PROJECT_PARENT foreign key (PARENT_ID) references PROJECT (ID) on delete cascade
);

create table MAIL_CASE
(
    ID bigint primary key,
    EMAIL     varchar(255) not null,
    NAME      varchar(255) not null,
    DATE_TIME timestamp    not null,
    RESULT    varchar(255) not null,
    TEMPLATE  varchar(255) not null
);

create table SPRINT
(
    ID bigint primary key,
    STATUS_CODE varchar(32)   not null,
    STARTPOINT  timestamp,
    ENDPOINT    timestamp,
    TITLE       varchar(1024) not null,
    PROJECT_ID  bigint        not null,
    constraint FK_SPRINT_PROJECT foreign key (PROJECT_ID) references PROJECT (ID) on delete cascade
);

create table REFERENCE
(
    ID bigint primary key,
    CODE       varchar(32)   not null,
    REF_TYPE   smallint      not null,
    ENDPOINT   timestamp,
    STARTPOINT timestamp,
    TITLE      varchar(1024) not null,
    AUX        varchar,
    constraint UK_REFERENCE_REF_TYPE_CODE unique (REF_TYPE, CODE)
);

create table USERS
(
    ID bigint primary key,
    DISPLAY_NAME varchar(32)  not null
        constraint UK_USERS_DISPLAY_NAME unique,
    EMAIL        varchar(128) not null
        constraint UK_USERS_EMAIL unique,
    FIRST_NAME   varchar(32)  not null,
    LAST_NAME    varchar(32),
    PASSWORD     varchar(128) not null,
    ENDPOINT     timestamp,
    STARTPOINT   timestamp
);

create table PROFILE
(
    ID                 bigint primary key,
    LAST_LOGIN         timestamp,
    LAST_FAILED_LOGIN  timestamp,
    MAIL_NOTIFICATIONS bigint,
    constraint FK_PROFILE_USERS foreign key (ID) references USERS (ID) on delete cascade
);

create table CONTACT
(
    ID    bigint not null,
    CODE  varchar(32) not null,
    `VALUE` varchar(256) not null,
    constraint PK_CONTACT primary key (ID, CODE),
    constraint FK_CONTACT_PROFILE foreign key (ID) references PROFILE (ID) on delete cascade
);

create table TASK
(
    ID bigint primary key,
    TITLE         varchar(1024) not null,
    DESCRIPTION   varchar(4096) not null,
    TYPE_CODE     varchar(32)   not null,
    STATUS_CODE   varchar(32)   not null,
    PRIORITY_CODE varchar(32)   not null,
    ESTIMATE      integer,
    UPDATED       timestamp,
    PROJECT_ID    bigint        not null,
    SPRINT_ID     bigint,
    PARENT_ID     bigint,
    STARTPOINT    timestamp,
    ENDPOINT      timestamp,
    constraint FK_TASK_SPRINT foreign key (SPRINT_ID) references SPRINT (ID) on delete set null,
    constraint FK_TASK_PROJECT foreign key (PROJECT_ID) references PROJECT (ID) on delete cascade,
    constraint FK_TASK_PARENT_TASK foreign key (PARENT_ID) references TASK (ID) on delete cascade
);

create table ACTIVITY
(
    ID bigint primary key,
    AUTHOR_ID     bigint not null,
    TASK_ID       bigint not null,
    UPDATED       timestamp,
    COMMENT       varchar(4096),
--     history of task field change
    TITLE         varchar(1024),
    DESCRIPTION   varchar(4096),
    ESTIMATE      integer,
    TYPE_CODE     varchar(32),
    STATUS_CODE   varchar(32),
    PRIORITY_CODE varchar(32),
    constraint FK_ACTIVITY_USERS foreign key (AUTHOR_ID) references USERS (ID),
    constraint FK_ACTIVITY_TASK foreign key (TASK_ID) references TASK (ID) on delete cascade
);

create table TASK_TAG
(
    TASK_ID bigint      not null,
    TAG     varchar(32) not null,
    constraint UK_TASK_TAG unique (TASK_ID, TAG),
    constraint FK_TASK_TAG foreign key (TASK_ID) references TASK (ID) on delete cascade
);

create table USER_BELONG
(
    ID bigint primary key,
    OBJECT_ID      bigint      not null,
    OBJECT_TYPE    smallint    not null,
    USER_ID        bigint      not null,
    USER_TYPE_CODE varchar(32) not null,
    STARTPOINT     timestamp,
    ENDPOINT       timestamp,
    constraint FK_USER_BELONG foreign key (USER_ID) references USERS (ID)
);
create unique index UK_USER_BELONG on USER_BELONG (OBJECT_ID, OBJECT_TYPE, USER_ID, USER_TYPE_CODE);
create index IX_USER_BELONG_USER_ID on USER_BELONG (USER_ID);

create table ATTACHMENT
(
    ID bigint primary key,
    NAME        varchar(128)  not null,
    FILE_LINK   varchar(2048) not null,
    OBJECT_ID   bigint        not null,
    OBJECT_TYPE smallint      not null,
    USER_ID     bigint        not null,
    DATE_TIME   timestamp,
    constraint FK_ATTACHMENT foreign key (USER_ID) references USERS (ID)
);

create table USER_ROLE
(
    USER_ID bigint   not null,
    ROLE    smallint not null,
    constraint UK_USER_ROLE unique (USER_ID, ROLE),
    constraint FK_USER_ROLE foreign key (USER_ID) references USERS (ID) on delete cascade
);

--changeset kmpk:populate_data
--============ References =================
insert into REFERENCE (ID, CODE, TITLE, REF_TYPE)
values (1, 'task', 'Task', 2),
       (2,'story', 'Story', 2),
       (3, 'bug', 'Bug', 2),
       (4, 'epic', 'Epic', 2),
-- SPRINT_STATUS
       (5, 'planning', 'Planning', 4),
       (6, 'active', 'Active', 4),
       (7, 'finished', 'Finished', 4),
-- USER_TYPE
       (8, 'author', 'Author', 5),
       (9, 'developer', 'Developer', 5),
       (10, 'reviewer', 'Reviewer', 5),
       (11, 'tester', 'Tester', 5),
-- PROJECT
       (12, 'scrum', 'Scrum', 1),
       (13, 'task_tracker', 'Task tracker', 1),
-- CONTACT
       (14, 'skype', 'Skype', 0),
       (15, 'tg', 'Telegram', 0),
       (16, 'mobile', 'Mobile', 0),
       (17, 'phone', 'Phone', 0),
       (18, 'website', 'Website', 0),
       (19, 'vk', 'VK', 0),
       (20, 'linkedin', 'LinkedIn', 0),
       (21, 'github', 'GitHub', 0),
-- PRIORITY
       (22, 'critical', 'Critical', 7),
       (23, 'high', 'High', 7),
       (24, 'normal', 'Normal', 7),
       (25, 'low', 'Low', 7),
       (26, 'neutral', 'Neutral', 7);

insert into REFERENCE (ID, CODE, TITLE, REF_TYPE, AUX)
-- MAIL_NOTIFICATION
values (27, 'assigned', 'Assigned', 6, '1'),
       (28, 'three_days_before_deadline', 'Three days before deadline', 6, '2'),
       (29, 'two_days_before_deadline', 'Two days before deadline', 6, '4'),
       (30, 'one_day_before_deadline', 'One day before deadline', 6, '8'),
       (31, 'deadline', 'Deadline', 6, '16'),
       (32, 'overdue', 'Overdue', 6, '32'),
-- TASK_STATUS
       (33, 'todo', 'ToDo', 3, 'in_progress,canceled'),
       (34, 'in_progress', 'In progress', 3, 'ready_for_review,canceled'),
       (35, 'ready_for_review', 'Ready for review', 3, 'review,canceled'),
       (36, 'review', 'Review', 3, 'in_progress,ready_for_test,canceled'),
       (37, 'ready_for_test', 'Ready for test', 3, 'test,canceled'),
       (38, 'test', 'Test', 3, 'done,in_progress,canceled'),
       (39, 'done', 'Done', 3, 'canceled'),
       (40, 'canceled', 'Canceled', 3, null);

--changeset gkislin:change_backtracking_tables

ALTER TABLE SPRINT RENAME COLUMN TITLE TO CODE;

ALTER TABLE SPRINT ALTER COLUMN CODE SET DATA TYPE VARCHAR(32);

ALTER TABLE SPRINT ALTER COLUMN CODE SET NOT NULL;

CREATE UNIQUE INDEX UK_SPRINT_PROJECT_CODE ON SPRINT (PROJECT_ID, CODE);

ALTER TABLE TASK
    DROP COLUMN DESCRIPTION;
ALTER TABLE TASK
    DROP COLUMN PRIORITY_CODE;
ALTER TABLE TASK
    DROP COLUMN ESTIMATE;
ALTER TABLE TASK
    DROP COLUMN UPDATED;

--changeset ishlyakhtenkov:change_task_status_reference

delete
from REFERENCE
where REF_TYPE = 3;
insert into REFERENCE (ID, CODE, TITLE, REF_TYPE, AUX)
values (41, 'todo', 'ToDo', 3, 'in_progress,canceled'),
       (42, 'in_progress', 'In progress', 3, 'ready_for_review,canceled'),
       (43, 'ready_for_review', 'Ready for review', 3, 'in_progress,review,canceled'),
       (44, 'review', 'Review', 3, 'in_progress,ready_for_test,canceled'),
       (45, 'ready_for_test', 'Ready for test', 3, 'review,test,canceled'),
       (46, 'test', 'Test', 3, 'done,in_progress,canceled'),
       (47, 'done', 'Done', 3, 'canceled'),
       (48, 'canceled', 'Canceled', 3, null);

--changeset gkislin:users_add_on_delete_cascade

ALTER TABLE ACTIVITY
    DROP CONSTRAINT IF EXISTS FK_ACTIVITY_USERS;

ALTER TABLE ACTIVITY
    ADD CONSTRAINT FK_ACTIVITY_USERS FOREIGN KEY (AUTHOR_ID) REFERENCES USERS (ID) ON DELETE CASCADE;

ALTER TABLE USER_BELONG
    DROP CONSTRAINT IF EXISTS FK_USER_BELONG;

ALTER TABLE USER_BELONG
    ADD CONSTRAINT FK_USER_BELONG FOREIGN KEY (USER_ID) REFERENCES USERS (ID) ON DELETE CASCADE;

ALTER TABLE ATTACHMENT
    DROP CONSTRAINT IF EXISTS FK_ATTACHMENT;

ALTER TABLE ATTACHMENT
    ADD CONSTRAINT FK_ATTACHMENT FOREIGN KEY (USER_ID) REFERENCES USERS (ID) ON DELETE CASCADE;
--changeset valeriyemelyanov:change_user_type_reference

delete
from REFERENCE
where REF_TYPE = 5;
insert into REFERENCE (ID, CODE, TITLE, REF_TYPE)
-- USER_TYPE
values (49, 'project_author', 'Author', 5),
       (50, 'project_manager', 'Manager', 5),
       (51, 'sprint_author', 'Author', 5),
       (52, 'sprint_manager', 'Manager', 5),
       (53, 'task_author', 'Author', 5),
       (54, 'task_developer', 'Developer', 5),
       (55, 'task_reviewer', 'Reviewer', 5),
       (56, 'task_tester', 'Tester', 5);

--changeset apolik:refactor_reference_aux

-- TASK_TYPE
delete
from REFERENCE
where REF_TYPE = 3;
insert into REFERENCE (ID, CODE, TITLE, REF_TYPE, AUX)
values (57, 'todo', 'ToDo', 3, 'in_progress,canceled|'),
       (58, 'in_progress', 'In progress', 3, 'ready_for_review,canceled|task_developer'),
       (59, 'ready_for_review', 'Ready for review', 3, 'in_progress,review,canceled|'),
       (60, 'review', 'Review', 3, 'in_progress,ready_for_test,canceled|task_reviewer'),
       (61, 'ready_for_test', 'Ready for test', 3, 'review,test,canceled|'),
       (62, 'test', 'Test', 3, 'done,in_progress,canceled|task_tester'),
       (63, 'done', 'Done', 3, 'canceled|'),
       (64, 'canceled', 'Canceled', 3, null);

--changeset ishlyakhtenkov:change_UK_USER_BELONG

ALTER TABLE USER_BELONG DROP CONSTRAINT IF EXISTS UK_USER_BELONG;

CREATE UNIQUE INDEX IF NOT EXISTS UK_USER_BELONG ON USER_BELONG (OBJECT_ID, OBJECT_TYPE, USER_ID, USER_TYPE_CODE) ;