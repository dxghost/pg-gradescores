
from rest_framework import serializers
from .models import *


class PersonSerializer(serializers.ModelSerializer):
    class Meta:
        model = Person
        fields = '__all__'


class StudentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Student
        fields = '__all__'
        extra_kwargs = {
            'personal': {'read_only': False,
                            'validators':[]},
        }

class TeacherSerializer(serializers.ModelSerializer):
    class Meta:
        model = Teacher
        fields = '__all__'


class SchoolSerializer(serializers.ModelSerializer):
    class Meta:
        model = School
        fields = '__all__'


class AddressSerializer(serializers.ModelSerializer):
    class Meta:
        model = Address
        fields = '__all__'


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
