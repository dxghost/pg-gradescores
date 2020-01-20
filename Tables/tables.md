### Person
| attribute     | domain      | pk  | fk  | unique | null | constraint  |
| ------------- | ----------- | --- | --- | ------ | ---- | ----------- |
| first_name    | varchar(20) |     |     |        |      |             |
| last_name     | varchar(40) |     |     |        |      |             |
| national_no   | serial      | x   |     | x      |      | length = 8  |
| date_of_birth | date        |     |     |        |      | before 2012 |

---

### School
| attribute  | domain       | pk  | fk  | unique | null | constraint |
| ---------- | ------------ | --- | --- | ------ | ---- | ---------- |
| address    | varchar(300) |     |     |        |      |            |
| id         | serial       | x   |     | x      |      |            |
| manager_id | int          |     | x   | x      |      |            |

---

### SchoolGrades
| attribute | domain | pk  | fk  | unique | null | constraint      |
| --------- | ------ | --- | --- | ------ | ---- | --------------- |
| school_id | int    | x   | x   |        |      |                 |
| grade_no  | int    | x   |     |        |      | in range (0:12) |

---

### SchoolStaff
| attribute | domain      | pk  | fk  | unique | null | constraint    |
| --------- | ----------- | --- | --- | ------ | ---- | ------------- |
| school_id | int         | x   | x   | x      |      |               |
| person_id | int         | x   | x   | x      |      |               |
| role      | varchar(20) |     |     |        |      | in roles_list |

---

### Student
| attribute         | domain      | pk  | fk  | unique | null | constraint |
| ----------------- | ----------- | --- | --- | ------ | ---- | ---------- |
| national_no       | int         | x   | x   | x      |      |            |
| educational_grade | varchar(10) |     |     |        |      |            |

---

### Teacher
| attribute   | domain       | pk  | fk  | unique | null | constraint |
| ----------- | ------------ | --- | --- | ------ | ---- | ---------- |
| national_no | int          | x   | x   | x      |      |            |
| degrees     | varchar(200) |     |     |        |      |            |


---

### School-Teacher
| attribute         | domain | pk  | fk  | unique | null | constraint |
| ----------------- | ------ | --- | --- | ------ | ---- | ---------- |
| teacher_national# | int    | x   | x   | x      |      |            |
| school_id         | int    | x   | x   | x      |      |            |


---

<!-- TODO Add Course table -->

### Exam
| attribute         | domain      | pk  | fk  | unique | null | constraint               |
| ----------------- | ----------- | --- | --- | ------ | ---- | ------------------------ |
| id                | serial      | x   |     | x      |      |                          |
| title             | varchar(60) |     |     |        | x    |                          |
| teacher_national# | int         |     | x   |        | x    |                          |
| course_id         | int         |     | x   |        |      |                          |
| exam_type         | varchar(10) |     |     |        |      | in('mid','final','quiz') |


### Subject
| attribute | domain       | pk  | fk  | unique | null | constraint |
| --------- | ------------ | --- | --- | ------ | ---- | ---------- |
| id        | serial       | x   |     | x      |      |            |
| category  | varchar(100) |     |     |        |      |            |
| course_id | int          |     | x   |        | x    |            |


---

### Question
| attribute     | domain        | pk  | fk  | unique | null | constraint |
| ------------- | ------------- | --- | --- | ------ | ---- | ---------- |
| id            | serial        | x   |     | x      |      |            |
| question_text | varcahar(300) |     |     |        |      |            |
| answer_text   | varchar(500)  |     |     |        | x    |            |
| comments      | varchar(200)  |     |     |        | x    |            |
| issued_by     | int           |     | x   |        | x    |            |

---

### Question-Subject
| attribute   | domain | pk  | fk  | unique | null | constraint |
| ----------- | ------ | --- | --- | ------ | ---- | ---------- |
| question_id | int    | x   | x   | x      |      |            |
| subject_id  | int    | x   | x   | x      |      |            |

---

### Exam-Question
| attribute   | domain | pk  | fk  | unique | null | constraint     |
| ----------- | ------ | --- | --- | ------ | ---- | -------------- |
| exam_id     | int    | x   | x   | x      |      |                |
| question_id | int    | x   | x   | x      |      |                |
| points      | int    |     |     |        |      | in range(0:20) |


---
<!-- TODO add a table for students to submit answers -->
<!-- TODO add support for 4-choice answers -->
### Exam-Evaluation
| attribute   | domain | pk  | fk  | unique | null | constraint |
| ----------- | ------ | --- | --- | ------ | ---- | ---------- |
| exam_id     | int    | x   | x   | x      |      |            |
| reviewed_by | int    |     |     |        |      |            |
| student_id  | int    | x   | x   | x      |      |            |
| points      | int    |     |     |        |      |            |

**Aggregation relations like parental observe affect the database design in creating views**