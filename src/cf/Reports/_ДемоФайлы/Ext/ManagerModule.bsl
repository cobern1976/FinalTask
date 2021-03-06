﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Настройки размещения в панели отчетов.
//
// Параметры:
//   Настройки - Коллекция - Передается "как есть" из ВариантыОтчетовПереопределяемый.НастроитьВариантыОтчетов().
//       Может использоваться для получения настроек варианта этого отчета при помощи функции ВариантыОтчетов.ОписаниеВарианта().
//   НастройкиОтчета - СтрокаДереваЗначений - Настройки этого отчета,
//       уже сформированные при помощи функции ВариантыОтчетов.ОписаниеОтчета() и готовые к изменению.
//       См. "Свойства для изменения" процедуры ВариантыОтчетовПереопределяемый.НастроитьВариантыОтчетов().
//
// Описание:
//   См. ВариантыОтчетовПереопределяемый.НастроитьВариантыОтчетов().
//
// Вспомогательные методы:
//	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "<ИмяВарианта>");
//	ВариантыОтчетов.УстановитьРежимВыводаВПанеляхОтчетов(Настройки, НастройкиОтчета, Истина/Ложь);
//
// Примеры:
//
//  1. Установка описания варианта.
//	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "<ИмяВарианта>");
//	НастройкиВарианта.Описание = НСтр("ru = '<Описание>'");
//
//  2. Отключение варианта отчета.
//	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "<ИмяВарианта>");
//	НастройкиВарианта.Включен = Ложь;
//
Процедура НастроитьВариантыОтчета(Настройки, НастройкиОтчета) Экспорт
	НастройкиОтчета.ОпределитьНастройкиФормы = Истина;
	НастройкиОтчета.Размещение.Удалить(Метаданные.Подсистемы._ДемоОрганайзер.Подсистемы._ДемоРаботаСФайлами);
	НастройкиОтчета.Размещение.Вставить(ВариантыОтчетовКлиентСервер.ИдентификаторНачальнойСтраницы(), "Важный");
	
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "Основной");
	НастройкиВарианта.Описание = НСтр("ru = 'Список файлов и их авторов в иерархии папок.'");
	НастройкиВарианта.НастройкиДляПоиска.КлючевыеСлова =
		НСтр("ru = 'Файловые функции
		|Динамика изменений файлов'");
	
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "ПоРазмеру");
	НастройкиВарианта.Описание = НСтр("ru = 'Топ-10 самых больших файлов, отредактированных за указанный период.'");
	НастройкиВарианта.НастройкиДляПоиска.КлючевыеСлова =
		НСтр("ru = 'Топ-10
		|Крупные файлы'");
	
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "ПоТипам");
	НастройкиВарианта.Описание = НСтр("ru = 'Круговая диаграмма использующихся типов файлов.'");
	НастройкиВарианта.НастройкиДляПоиска.КлючевыеСлова =
		НСтр("ru = 'Расширения'");
	
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "ПоВерсиям");
	НастройкиВарианта.Описание = НСтр("ru = 'Список версий, файлов и папок в табличном виде.'");
	НастройкиВарианта.НастройкиДляПоиска.КлючевыеСлова =
		НСтр("ru = 'Версии
		|Загруженные файлы'");
	
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "Вспомогательный");
	НастройкиВарианта.Включен = Ложь;
КонецПроцедуры

#КонецОбласти

#КонецЕсли