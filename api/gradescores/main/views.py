from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import permissions, viewsets
from .models import *
from .serializers import *


class PersonViewset(viewsets.ModelViewSet):
    queryset = Person.objects.all()
    serializer_class = PersonSerializer
    @action(detail=True, url_path='children-reports')
    def get_children_scores(self, request, *args, **kwargs):
        # your rest of code and response
        queryset = ExamEvaluation.objects.filter(
            student__in=self.get_object().children.all())
        serializer = ExamEvaluationSerializer(queryset, many=True)
        return Response(data=serializer.data)


class StudentViewset(viewsets.ModelViewSet):
    queryset = Student.objects.all()
    serializer_class = StudentSerializer

class ExamEvaluationViewset(viewsets.ModelViewSet):
    queryset = ExamEvaluation.objects.all()
    serializer_class = ExamEvaluationSerializer

class TeacherViewset(viewsets.ModelViewSet):
    queryset = Teacher.objects.all()
    serializer_class = TeacherSerializer

    @action(detail=True, url_path='exams')
    def get_exams(self, request, *args, **kwargs):
        # your rest of code and response
        queryset = Exam.objects.filter(
            corresponding_class__teacher=self.get_object())
        serializer = ExamSerializer(queryset, many=True)
        return Response(data=serializer.data)

    @action(detail=True, url_path='questions')
    def get_questions(self, request, *args, **kwargs):
        # your rest of code and response
        queryset = Question.objects.filter(
            issuer=self.get_object())
        serializer = QuestionSerializer(queryset, many=True)
        return Response(data=serializer.data)


class SchoolViewset(viewsets.ModelViewSet):
    queryset = School.objects.all()
    serializer_class = SchoolSerializer

    @action(detail=True, url_path='teachers')
    def open(self, request, *args, **kwargs):
        # your rest of code and response
        queryset = self.get_object().teachers
        serializer = TeacherSerializer(queryset, many=True)
        return Response(data=serializer.data)


class AddressViewset(viewsets.ModelViewSet):
    queryset = Address.objects.all()
    serializer_class = AddressSerializer


class ClassViewset(viewsets.ModelViewSet):
    queryset = Class.objects.all()
    serializer_class = ClassSerializer


class CourseViewset(viewsets.ModelViewSet):
    queryset = Course.objects.all()
    serializer_class = CourseSerializer


class ExamViewset(viewsets.ModelViewSet):
    queryset = Exam.objects.all()
    serializer_class = ExamSerializer

    @action(detail=True, url_path='submissions')
    def get_submissions(self, request, *args, **kwargs):
        # your rest of code and response
        queryset = Submission.objects.filter(exam=self.get_object())
        serializer = SubmissionSerializer(queryset, many=True)
        return Response(data=serializer.data)


class FourChoiceViewset(viewsets.ModelViewSet):
    queryset = FourChoice.objects.all()
    serializer_class = FourChoiceSerializer


class QuestionViewset(viewsets.ModelViewSet):
    queryset = Question.objects.all()
    serializer_class = QuestionSerializer


class SubmissionViewset(viewsets.ModelViewSet):
    queryset = Submission.objects.all()
    serializer_class = SubmissionSerializer
