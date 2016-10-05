﻿#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	Оповещение = Новый ОписаниеОповещения("ОбработкаКомандыЗавершение", ЭтотОбъект);
	ПроверкаЛегальностиПолученияОбновленияКлиент.ПоказатьПроверкуЛегальностиПолученияОбновления(Оповещение);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОбработкаКомандыЗавершение(Результат, ДополнительныеПараметры) Экспорт
	Перем ТекстСообщения;
	
	Если Результат = Истина Тогда
		ТекстСообщения = НСтр("ru = 'Легальность получения обновления подтверждена.'");
	Иначе
		ТекстСообщения = НСтр("ru = 'Обновление получено нелегально.'");
	КонецЕсли;
	
	ПоказатьПредупреждение(,ТекстСообщения);
	
КонецПроцедуры

#КонецОбласти