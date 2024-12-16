a = 5
b = 3
c = None
i = 0
if a == b:
    print("a равно b")
else:
    print("a  не равно b")
c = a
    print("Значение c установлено:")
if a > b:
    print("a  больше b ")
else:
    print("b  больше или равно a ")
print("Начало цикла while")
while i < 5:
    print("Цикл выполняется")
    i = i + 1
print("Цикл завершён")
if b == 20:
    print("b равно 20")
else:
    print("b не равно 20")
print("Проверяем значение a в switch")
match a:
    case 10:
        print("a равно 10")
    case 20:
        print("a равно 20")
    case _:
        print("a  имеет другое значение")
i = 0
print("Начало второго цикла while")
while i < 3:
    print("Значение i меньше 3: ")
    i = i + 1
    print("Второй цикл завершён")
if c < b:
    print("c  меньше b ")
else:
    print("c  больше или равно b ")
