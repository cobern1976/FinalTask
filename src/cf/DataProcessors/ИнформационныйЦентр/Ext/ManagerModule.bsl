﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Добавляет в текст сообщения от пользователя информацию о текущем приложении.
//
// Параметры:
//  ТекстHTML - Строка - текст сообщения пользователя.
//
Процедура ДобавитьИнформациюОПриложении(ТекстHTML) Экспорт
    
    СтруктураURL = ОбщегоНазначенияКлиентСервер.СтруктураURI(ПолучитьНавигационнуюСсылкуИнформационнойБазы());
    СистемнаяИнформация = Новый СистемнаяИнформация();
    
    ТекстHTML = ТекстHTML + Символы.ПС + СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку( 
        "<!-- @AddInfo 
        |{
        |   ""host"": ""%1"",
        |   ""port"": ""%2"",
        |   ""zone"": ""%3"",
        |   ""platformVersion"": ""%4"",
        |   ""configVersion"": ""%5"",
        |   ""configName"": ""%6"",
        |} 
        |-->", 
        СтруктураURL.Хост, 
        Формат(СтруктураURL.Порт,"ЧГ=0"),
        Формат(ТехнологияСервисаИнтеграцияСБСП.ЗначениеРазделителяСеанса(),"ЧГ=0"),
        СистемнаяИнформация.ВерсияПриложения,
        Метаданные.Версия,
        Метаданные.Имя);
	
КонецПроцедуры
 

#КонецОбласти

#КонецЕсли 