﻿
#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	ОткрытьФорму(
		"Обработка.ИнструментыРазработчикаДополнительныеОтчетыИОбработкиРасстановкаФрагментовКода.Форма",
		Новый Структура,
		ПараметрыВыполненияКоманды.Источник,
		ПараметрыВыполненияКоманды.Уникальность);
КонецПроцедуры

#КонецОбласти
