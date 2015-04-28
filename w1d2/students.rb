class Student
  attr_reader :first, :last

  attr_accessor :courses

  def initialize(first_name, last_name)
    @first = first_name
    @last  = last_name
    @courses = []
  end

  def name
    "#{first} #{last}"
  end

  def course_list
    self.courses.each do |course|
        puts course.name
    end
  end

  def enroll(new_course)

    if has_conflict?(new_course)
      raise "Conflicting Course"
    else
      courses << new_course
      new_course.add_student(self)
    end
  end

  def course_load
    course_load = {}
    self.courses.each do |course|
      course_load[course.department] = course.credits
    end
    course_load
  end

  def has_conflict?(new_course)
    self.courses.each do |course|
      return true if new_course.conflicts_with?(course)
    end
    false
  end
end

class Course
  attr_reader :credits, :department, :name, :time, :days

  attr_accessor :students

  def initialize(course_name, department, num_credits, time, days)
    @name = course_name
    @department = department
    @credits = num_credits
    @students = []
    @time = time
    @days = days
  end

  def student_list
    self.students.each do |student|
        puts student.name
      end
  end

  def add_student(student)
    students << student
  end

  def conflicts_with?(course)
  return true if self.time == course.time &&
              self.days.any? { |day| course.days.include?(day)}
        false
  end
end

student = Student.new("James", "Brown")
course1 = Course.new("Biology", "Science", 4, 1, [:mon])
student.enroll(course1)
p student.course_load
student.course_list
course1.student_list
course2 = Course.new("Business of things", "Business", 3, 2, [:mon, :fri])
p course1.conflicts_with?(course2)
student.enroll(course2)
