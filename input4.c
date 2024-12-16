
    int a = 5;     
    int b = 3;     
    int c;         
    int i = 0;     

    if (a == b) {
        printf("a равно b");
    } else {
        printf("a  не равно b");
    }

    c = a; 
    printf("Значение c установлено:");

    if (a > b) {
        printf("a  больше b ");
    } else {
        printf("b  больше или равно a ");
    }

    printf("Начало цикла while");
    while (i < 5) {
        printf("Цикл выполняется");
        i = i + 1;
    }
    printf("Цикл завершён");

    if (b == 20) {
        printf("b равно 20");
    } else {
        printf("b не равно 20");
    }

    printf("Проверяем значение a в switch");
    switch (a) {
        case 10:
            printf("a равно 10");
            break;
        case 20:
            printf("a равно 20");
            break;
        default:
            printf("a  имеет другое значение");
            break;
    }

    i = 0; 
    printf("Начало второго цикла while");
    while (i < 3) {
        printf("Значение i меньше 3: ");
        i = i + 1;
    }
    printf("Второй цикл завершён");

    if (c < b) {
        printf("c  меньше b ");
    } else {
        printf("c  больше или равно b ");
    }


