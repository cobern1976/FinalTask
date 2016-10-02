﻿# encoding: utf-8
# language: ru

@tree

Функционал: Отражение процсса закупки
	Как Менеджер
	Хочу Отразить закупку материалов системе
	И Проверить остатки
	Чтобы Знать состояние склада
Контекст
    Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	И Пауза 3
Сценарий: Регистрация поступления товаров
	Допустим Если покупка то признак очистки 1
	Когда В панели разделов я выбираю "Тестовая разработка"
	И     В панели функций я выбираю "Тест: Покупка товара"
	Тогда открылось окно "Тест: Покупка товара"
	И     я нажимаю на кнопку "Создать"
	Тогда открылось окно "(Тест) Покупка *"
	И     я открываю выпадающий список "Место хранения"
	И     я нажимаю кнопку выбора у поля "Место хранения"
	И     из выпадающего списка "Место хранения" я выбираю "Тест: Склад"
	И     в ТЧ "Товары" я нажимаю на кнопку "Добавить"
	И     В форме "(Тест) Покупка (создание)" в ТЧ "Товары" я выбираю текущую строку
	И     в ТЧ "Товары" из выпадающего списка "Номенклатура" я выбираю "Вентилятор настольный"
	И     я перехожу к следующему реквизиту
	И     в ТЧ "Товары" я активизирую поле "Количество"
	И     в ТЧ "Товары" в поле "Количество" я ввожу текст "10,000"
	И     я перехожу к следующему реквизиту
	И     в ТЧ "Товары" я активизирую поле "Цена"
	И     в ТЧ "Товары" в поле "Цена" я ввожу текст "500,00"
	И     В форме "(Тест) Покупка (создание)" в ТЧ "Товары" я завершаю редактирование строки
	И     в ТЧ "Товары" я нажимаю на кнопку "Добавить"
	И     В форме "(Тест) Покупка (создание)" в ТЧ "Товары" я выбираю текущую строку
	И     в ТЧ "Товары" из выпадающего списка "Номенклатура" я выбираю "Кондиционер ELEKTA"
	И     я перехожу к следующему реквизиту
	И     в ТЧ "Товары" я активизирую поле "Количество"
	И     в ТЧ "Товары" в поле "Количество" я ввожу текст "1,000"
	И     в ТЧ "Товары" я активизирую поле "Цена"
	И     в ТЧ "Товары" в поле "Цена" я ввожу текст "6 000,00"
	И     В форме "(Тест) Покупка (создание)" в ТЧ "Товары" я завершаю редактирование строки
	И     я нажимаю на кнопку "Провести"
	И     Я закрываю окно "(Тест) Покупка *"
	Тогда Покупка отражена корректно
	Когда В панели разделов я выбираю "Тестовая разработка"
	Тогда открылось окно "Тест: Покупка товара"
	И     В панели функций я выбираю "Тест отчет по остаткам"
	Тогда открылось окно "Основной"
	И     я открываю выпадающий список "Период отчета"
	И     из выпадающего списка "Период отчета" я выбираю "Начало завтрашнего дня"
	И     я нажимаю на кнопку "Сформировать"
	И     Пауза 2
	И табличный документ формы с именем "ОтчетТабличныйДокумент" стал равен:
		| 'Параметры:'            | '*' 						 |
		| ''                      | ''                           |
		| 'Место хранения'        | 'Количество'                 |
		| 'Номенклатура'          | ''                           |
		| 'Тест: Склад'           | '11,000'                     |
		| 'Вентилятор настольный' | '10,000'                     |
		| 'Кондиционер ELEKTA'    | '1,000'                      |
		| 'Итого'                 | '11,000'                     |


