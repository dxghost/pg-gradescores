
from rest_framework import serializers
from .models import *


class PersonSerializer(serializers.ModelSerializer):
    class Meta:
        model = Person
        fields = ["id","national_no","first_name","last_name","date_of_birth","gender"]





class TeacherSerializer(serializers.ModelSerializer):
    personal = PersonSerializer()

    class Meta:
        model = Teacher
        fields = '__all__'
        extra_kwargs = {
            'personal': {'read_only': False,
                            'validators':[]},
        }

    
    def create(self, validated_data):
        personal_data = validated_data.pop('personal')

        personal = Person.objects.create(**personal_data)
        validated_data["personal"]=personal 
        teacher = Teacher.objects.create(**validated_data)
        return teacher
    
class TeacherBriefSerializer(serializers.ModelSerializer):
    class Meta:
        model=Teacher
        fields=["personal"]
        extra_kwargs = {
            'personal': {'read_only': False,
                            'validators':[]},
        }
class AddressSerializer(serializers.ModelSerializer):
    class Meta:
        model = Address
        fields = '__all__'


class SchoolSerializer(serializers.ModelSerializer):
    address = AddressSerializer()
    teachers = TeacherBriefSerializer(many=True,required=False)
    class Meta:
        model = School
        fields = '__all__'
    def create(self, validated_data):
        address_data = validated_data.pop('address')
        teachers_data = validated_data.pop('teachers')

        created_address = Address.objects.create(**address_data)
        validated_data["address"]=created_address 
        school = School.objects.create(**validated_data)
        for teacher_data in teachers_data:
            school.teachers.add(Teacher.objects.get(**teacher_data))
        return school

class SchoolBriefSerializer(serializers.ModelSerializer):
    class Meta:
        model = School
        fields = ["id"]
class StudentSerializer(serializers.ModelSerializer):
    personal = PersonSerializer()
    school = SchoolBriefSerializer()
    class Meta:
        model = Student
        fields = '__all__'
        extra_kwargs = {
            'personal': {'read_only': False,
                            'validators':[]},
        }
    
    def create(self, validated_data):
        personal_data = validated_data.pop('personal')
        school_data = validated_data.pop("school")
        print(school_data)
        personal = Person.objects.create(**personal_data)
        school = School.objects.get(**school_data)
        validated_data["personal"]=personal 
        validated_data["school"]=school
        student = Student.objects.create(**validated_data)
        return student
    

class ClassSerializer(serializers.ModelSerializer):
    students = StudentSerializer(many=True,required=False)

    class Meta:
        model = Class
        fields = ["id","course", "teacher", "school", "students"]

    def create(self, validated_data):
        students_data = list(validated_data.pop('students'))
        # print(students_data)
        corresponding_class = Class.objects.create(**validated_data)
        for student_data in students_data:
            corresponding_class.students.add(Student.objects.get(personal=student_data["personal"]))
        return corresponding_class
    

class CourseSerializer(serializers.ModelSerializer):
    class Meta:
        model = Course
        fields = '__all__'


class ExamSerializer(serializers.ModelSerializer):
    class Meta:
        model = Exam
        fields = '__all__'


class FourChoiceSerializer(serializers.ModelSerializer):
    class Meta:
        model = FourChoice
        fields = '__all__'


class QuestionSerializer(serializers.ModelSerializer):
    choices = FourChoiceSerializer()

    class Meta:
        model = Question
        fields = ["question_text", "answer_text", "comments",
                  "choices", "correct_choice", "issuer"]

    def create(self, validated_data):
        choices_data = validated_data.pop('choices')
        four_choices = FourChoice.objects.create(**choices_data)
        # validated_data["choices   "]=four_choices.id
        print(type(four_choices))
        validated_data["choices"] = four_choices
        print(validated_data)
        question = Question.objects.create(
            **validated_data)
        # question.choices = choices
        # question.save()
        return question


class SubmissionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Submission
        fields = '__all__'
