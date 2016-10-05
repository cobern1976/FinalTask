﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Если Объект.ЭтотУзел Тогда
		
		Элементы.НастройкаФильтровРегистрации.Видимость = Ложь;
		
		КоманднаяПанель.ПодчиненныеЭлементы.ФормаВыполнениеОбменаДанными.Видимость = Ложь;
		
	КонецЕсли;
	
	СтандартныеПодсистемыСервер.УстановитьОтображениеЗаголовковГрупп(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	
	Оповестить("Запись_УзелПланаОбмена");
	
КонецПроцедуры

#КонецОбласти
