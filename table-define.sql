    create table major(
        id     int unsigned not null auto_increment primary key ,
        name   varchar(16) comment '名字' ,
        unique index uix_major_name(name)
    );

    insert into major(name) values('软件工程'),('计算机科学与技术'),('网络工程'),
                              ('经济学'),('金融学'),('会计学'),('国际贸易');


    create table student(
        id        int unsigned not null auto_increment primary key,
        name      varchar(8)      comment '名字',
        birthday  date            comment '生日',
        sid       int unsigned    comment '学号',
        major     int unsigned    comment '专业' ,
        constraint fk_student_major foreign key (major) references major(id) 
        on delete cascade on update cascade
    );

    create table teacher(
        id       int unsigned not null auto_increment primary key,
        name     varchar(8)     comment '名字',
        birthday date           comment '生日',
        tid      int unsigned   comment '职工号',
        major    int unsigned   comment '所教授的专业',
        salary   float unsigned comment '月薪',
        entry    date           comment '入职日期',
        constraint fk_teacher_major foreign key(major) references major(id)
    );

    create table klass( -- class 在许多编程语言中都是关键字、所以在数据库中就用klass代替它了
        id       int unsigned not null auto_increment primary key,
        birthday date         comment '班级成立的日期',
        name     varchar(16)  comment '班级的名字',
        charge   int unsigned comment '班主任老师',
        constraint fk_klass_charge foreign key(charge) references teacher(id)
    );

    create table klass_to_student(
        id         int unsigned not null auto_increment primary key,
        klass_id   int unsigned not null,
        student_id int unsigned not null,

        constraint fk_klass_to_student_klass_id   foreign key(klass_id)   references klass(id),
        constraint fk_klass_to_student_student_id foreign key(student_id) references student(id),
        unique index uix_klass_to_student_klass_id_student_id(klass_id,student_id)
    );

    create table klass_to_teacher(
        id         int unsigned not null auto_increment primary key,
        klass_id   int unsigned not null,
        teacher_id int unsigned not null,

        constraint fk_klass_to_teacher_klass_id foreign key(klass_id)     references klass(id),
        constraint fk_klass_to_teacher_teacher_id foreign key(teacher_id) references teacher(id),
        unique index uix_klass_to_teacher_klass_id_teacher_id(klass_id,teacher_id)
    );