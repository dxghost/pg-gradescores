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

### Course
| attribute | domain      | pk  | fk  | unique | null | constraint |
| --------- | ----------- | --- | --- | ------ | ---- | ---------- |
| id        | serial      | x   |     | x      |      |            |
| title     | varchar(40) |     |     | x      |      |            |
**implemented in order to be compatible with additional requirements**

---

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
| issued_by      | int           |     | x   |        | x    |            |
| choices        | int           |     | x   | x      | x    |            |
| correct_choice | int           |     |     |        | x    |            |

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
| id          | serial | x   |     | x      |      |                |
| exam_id     | int    |     | x   | x      |      |                |
| question_id | int    |     | x   | x      |      |                |
| points      | int    |     |     |        |      | in range(0:20) |
**exam_id and question_id are unique together**

---
### Submission
| attribute     | domain | pk  | fk  | unique | null | constraint     |
| ------------- | ------ | --- | --- | ------ | ---- | -------------- |
| eq_id         | int    | x   | x   |        |      |                |
| student_no    | int    | x   | x   |        |      | in range(0:20) |
| points_earned | int    |     |     |        | x    |                |
| examiner_no   | int    |     | x   |        |      |                |

---

### Exam-Evaluation
| attribute   | domain | pk  | fk  | unique | null | constraint |
| ----------- | ------ | --- | --- | ------ | ---- | ---------- |
| exam_id     | int    | x   | x   | x      |      |            |
| reviewed_by | int    |     |     |        |      |            |
| student_id  | int    | x   | x   | x      |      |            |
| points      | int    |     |     |        |      |            |

**Aggregation relations like parental observe affect the database design in creating views**