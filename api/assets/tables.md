### Person
| attribute     | domain      | pk  | fk  | unique | null | constraint   |
| ------------- | ----------- | --- | --- | ------ | ---- | ------------ |
| first_name    | varchar(20) |     |     |        |      |              |
| last_name     | varchar(40) |     |     |        |      |              |
| national_no   | serial      | x   |     | x      |      | length = 8   |
| date_of_birth | date        |     |     |        |      | before 2012  |
| gender        | char        |     |     |        |      | in ('m','f') |

---

### School
| attribute  | domain      | pk  | fk  | unique | null | constraint   |
| ---------- | ----------- | --- | --- | ------ | ---- | ------------ |
| name       | varchar(50) |     |     |        |      |              |
| address_id | int         |     |     | x      |      |              |
| id         | int         | x   |     | x      |      |              |
| manager_id | int         |     | x   | x      |      |              |
| gender     | char        |     |     |        |      | in ('m','f') |

---

### Address
| attribute | domain      | pk  | fk  | unique | null | constraint |
| --------- | ----------- | --- | --- | ------ | ---- | ---------- |
| id        | int         | x   |     | x      |      |            |
| province  | varchar(50) |     |     |        |      |            |
| city      | varchar(50) |     |     |        |      |            |
| district  | varchar(50) |     |     |        | x    |            |
| street    | varchar(50) |     |     |        | x    |            |
| zipcode   | varchar(10) |     |     | x      |      |            |

---

### Student
| attribute         | domain | pk  | fk  | unique | null | constraint     |
| ----------------- | ------ | --- | --- | ------ | ---- | -------------- |
| national_no       | int    | x   | x   | x      |      |                |
| educational_id    | int    |     |     | x      |      |                |
| educational_grade | int    |     |     |        |      | in range(1:12) |

---

### Teacher
| attribute   | domain       | pk  | fk  | unique | null | constraint |
| ----------- | ------------ | --- | --- | ------ | ---- | ---------- |
| national_no | int          | x   | x   | x      |      |            |
| teacher_id  | int          |     |     | x      |      |            |
| degrees     | varchar(200) |     |     |        |      |            |


---

### StudentParent
| attribute           | domain | pk  | fk  | unique | null | constraint |
| ------------------- | ------ | --- | --- | ------ | ---- | ---------- |
| student_national_no | int    | x   | x   |        |      |            |
| parent_national_no  | int    | x   | x   |        |      |            |

---

### SchoolGrades
| attribute | domain | pk  | fk  | unique | null | constraint      |
| --------- | ------ | --- | --- | ------ | ---- | --------------- |
| school_id | int    | x   | x   |        |      |                 |
| grade_no  | int    | x   |     |        |      | in range (0:12) |

---

### StudentSchool
| attribute           | domain | pk  | fk  | unique | null | constraint |
| ------------------- | ------ | --- | --- | ------ | ---- | ---------- |
| student_national_no | int    | x   | x   |        |      |            |
| school_id           | int    | x   | x   |        |      |            |

---

### TeacherSchool
| attribute           | domain | pk  | fk  | unique | null | constraint |
| ------------------- | ------ | --- | --- | ------ | ---- | ---------- |
| teacher_national_no | int    | x   | x   |        |      |            |
| school_id           | int    | x   | x   |        |      |            |

---

### Course
| attribute | domain      | pk  | fk  | unique | null | constraint |
| --------- | ----------- | --- | --- | ------ | ---- | ---------- |
| id        | serial      | x   |     | x      |      |            |
| title     | varchar(40) |     |     | x      |      |            |
**implemented in order to be compatible with additional requirements**

---

### Class
| attribute           | domain | pk  | fk  | unique | null | constraint |
| ------------------- | ------ | --- | --- | ------ | ---- | ---------- |
| id                  | int    | x   | x   | x      |      |            |
| student_national_no | int    |     | x   | x      |      |            |
| teacher_national_no | int    |     | x   | x      |      |            |
| course_id           | int    |     | x   | x      |      |            |
| school_id           | int    |     | x   | x      |      |            |
**fields except id are unique_together**

---

### Exam
| attribute | domain      | pk  | fk  | unique | null | constraint               |
| --------- | ----------- | --- | --- | ------ | ---- | ------------------------ |
| id        | serial      | x   |     | x      |      |                          |
| title     | varchar(60) |     |     |        | x    |                          |
| class_id  | serial      |     |     |        |      |                          |
| exam_type | varchar(10) |     |     |        |      | in('mid','final','quiz') |
| points    | int         |     |     |        | x    |                          |

****`points`** is a read-only field which is incremented after insertion on examquestion**

---


### FourChoices
| attribute     | domain       | pk  | fk  | unique | null | constraint |
| ------------- | ------------ | --- | --- | ------ | ---- | ---------- |
| id            | serial       | x   |     | x      |      |            |
| first_choice  | varchar(100) |     |     |        |      |            |
| second_choice | varchar(100) |     |     |        |      |            |
| third_choice  | varchar(100) |     |     |        |      |            |
| fourth_choice | varchar(100) |     |     |        |      |            |

---

### Question
| attribute      | domain        | pk  | fk  | unique | null | constraint |
| -------------- | ------------- | --- | --- | ------ | ---- | ---------- |
| id             | serial        | x   |     | x      |      |            |
| question_text  | varcahar(300) |     |     |        |      |            |
| answer_text    | varchar(500)  |     |     |        | x    |            |
| comments       | varchar(200)  |     |     |        | x    |            |
| issued_by      | int           |     | x   |        |      |            |
| choices        | int           |     | x   | x      | x    |            |
| correct_choice | int           |     |     |        | x    |            |

---

### Exam-Question
| attribute   | domain | pk  | fk  | unique | null | constraint |
| ----------- | ------ | --- | --- | ------ | ---- | ---------- |
| id          | serial | x   |     | x      |      |            |
| exam_id     | int    |     | x   | x      |      |            |
| question_id | int    |     | x   | x      |      |            |
| points      | int    |     |     |        |      |            |
**exam_id and question_id are unique together**

---

### Submission/Review
| attribute           | domain       | pk  | fk  | unique | null | constraint                               | default        |
| ------------------- | ------------ | --- | --- | ------ | ---- | ---------------------------------------- | -------------- |
| question_id         | int          | x   | x   | x      |      |                                          |                |
| exam_id             | int          | x   | x   | x      |      |                                          |                |
| student_national_no | int          | x   | x   | x      |      |                                          |                |
| reviewed_by         | int          |     | x   |        |      |                                          |                |
| answer_text         | varchar(500) |     |     |        |      |                                          |                |
| answered_choice     | int          |     |     |        |      |                                          |                |
| points              | int          |     |     |        |      |                                          |                |
| status              | varchar(10)  |     |     |        |      | in("not-reviewed","approved","rejected") | "not-reviewed" |


**Aggregation relations like parental observe affect the database design in creating views**