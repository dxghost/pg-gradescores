from django.db import models


GENDER_CHOICES = [
    ('m', 'male'),
    ('f', 'female')
]
EXAM_TYPE_CHOICES = [
    ('m', 'mid'),
    ('f', 'final'),
    ('q', 'quiz')
]
REVIEW_TYPE_CHOICES = [
    ('n', 'not-reviewed'),
    ('a', 'approved'),
    ('r', 'rejected')
]


class Person(models.Model):
    first_name = models.CharField(max_length=20)
    last_name = models.CharField(max_length=40)
    national_no = models.IntegerField(unique=True)
    date_of_birth = models.DateField()
    # children = models.ManyToManyField(Person)
    gender = models.CharField(max_length=1, choices=GENDER_CHOICES)


class Address(models.Model):
    province = models.CharField(max_length=50, null=False)
    city = models.CharField(max_length=50, null=False)
    district = models.CharField(max_length=50)
    street = models.CharField(max_length=50)
    zipcode = models.CharField(max_length=10, null=False, unique=True)


class Student(models.Model):
    personal = models.OneToOneField(
        Person, on_delete=models.CASCADE, primary_key=True)
    educational_id = models.IntegerField(unique=True)
    educational_grade = models.IntegerField(
        choices=[(i, i) for i in range(1, 13)])


class Teacher(models.Model):
    personal = models.OneToOneField(
        Person, on_delete=models.CASCADE, primary_key=True)
    teacher_id = models.IntegerField(unique=True)
    degrees = models.CharField(max_length=200)


class School(models.Model):
    name = models.CharField(max_length=50)
    address = models.ForeignKey(Address, on_delete=models.CASCADE)
    manager = models.ForeignKey(Person, on_delete=models.CASCADE)
    gender = models.CharField(max_length=1, choices=GENDER_CHOICES)
    teachers = models.ManyToManyField(Teacher,blank=True,null=True)
    students = models.ManyToManyField(Student,blank=True,null=True)



class SchoolGrade(models.Model):
    school = models.ForeignKey(School, on_delete=models.CASCADE)
    grade_no = models.IntegerField(choices=[(i, i) for i in range(1, 12)])

    class Meta:
        unique_together = (("school", "grade_no"),)


class Course(models.Model):
    title = models.CharField(max_length=40)


class Class(models.Model):
    teacher = models.ForeignKey(Teacher, on_delete=models.CASCADE)
    course = models.ForeignKey(Course, on_delete=models.CASCADE)
    school = models.ForeignKey(School, on_delete=models.CASCADE)
    students = models.ManyToManyField(Student)
    class Meta:
        unique_together = (("teacher", "course", "school"),)



class Exam(models.Model):
    title = models.CharField(max_length=60)
    corresponding_class = models.ForeignKey(Class, on_delete=models.CASCADE)
    exam_type = models.CharField(max_length=10, choices=EXAM_TYPE_CHOICES)
    points = models.IntegerField()


class FourChoice(models.Model):
    first_choice = models.CharField(max_length=100)
    second_choice = models.CharField(max_length=100)
    third_choice = models.CharField(max_length=100)
    fourth_choice = models.CharField(max_length=100)


class Question(models.Model):
    question_text = models.CharField(max_length=300)
    answer_text = models.CharField(max_length=500)
    comments = models.CharField(max_length=200)
    choices = models.ForeignKey(FourChoice, on_delete=models.DO_NOTHING)
    correct_choice = models.IntegerField(choices=[(i, i) for i in range(1, 5)])
    issuer = models.ForeignKey(
        Teacher, on_delete=models.DO_NOTHING, null=True, blank=True)


class ExamQuestion(models.Model):
    exam = models.ForeignKey(Exam, on_delete=models.CASCADE)
    question = models.ForeignKey(Question, on_delete=models.CASCADE)
    points = models.IntegerField()

    class Meta:
        unique_together = (("exam", "question"),)


class Submission(models.Model):
    eq = models.ForeignKey(ExamQuestion, on_delete=models.CASCADE)
    student = models.ForeignKey(Student, on_delete=models.CASCADE)
    examinar = models.ForeignKey(Teacher, on_delete=models.CASCADE)
    points = models.IntegerField()
    answer = models.CharField(max_length=500, null=False)
    sts = models.CharField(max_length=10, choices=REVIEW_TYPE_CHOICES)
    answered_choice = models.IntegerField(
        choices=[(i, i) for i in range(1, 5)])

    class Meta:
        unique_together = (("student", "eq"),)


class ExamEvaluation(models.Model):
    exam = models.ForeignKey(Exam, on_delete=models.CASCADE)
    student = models.ForeignKey(Student, on_delete=models.CASCADE)
    points = models.IntegerField()

    class Meta:
        unique_together = (("student", "exam"),)
