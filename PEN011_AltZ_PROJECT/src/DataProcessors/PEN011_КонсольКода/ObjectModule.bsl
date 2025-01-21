#Область ПрограммныйИнтерфейс

// Возвращает данные для регистрации в качестве внешней обработки
// 
// Возвращаемое значение:
//  Структура - вся информация для регистрации
//
Функция СведенияОВнешнейОбработке() Экспорт
	
	РегистрационныеДанные = Новый Структура;
	
	Команды = Новый ТаблицаЗначений;
	Команды.Колонки.Добавить("Представление", Новый ОписаниеТипов("Строка"));
	Команды.Колонки.Добавить("Идентификатор", Новый ОписаниеТипов("Строка"));
	Команды.Колонки.Добавить("Использование", Новый ОписаниеТипов("Строка"));
	Команды.Колонки.Добавить("ПоказыватьОповещение", Новый ОписаниеТипов("Булево"));
	Команды.Колонки.Добавить("Модификатор"  , Новый ОписаниеТипов("Строка"));
	
	ДобавитьКоманду(Команды, "Консоль кода", "КонсольКода", "ОткрытиеФормы");
	
	РегистрационныеДанные.Вставить("Вид"             , "ДополнительнаяОбработка");
	РегистрационныеДанные.Вставить("Назначение"      , Неопределено);
	РегистрационныеДанные.Вставить("Наименование"    , "Консоль кода");
	РегистрационныеДанные.Вставить("Версия"          , "20221014");
	РегистрационныеДанные.Вставить("БезопасныйРежим" , Ложь);
	РегистрационныеДанные.Вставить("Информация"      , "Консоль кода для управляемых форм");
	РегистрационныеДанные.Вставить("Команды"         , Команды);
	
	Возврат РегистрационныеДанные;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ДобавитьКоманду(Команды, Представление, Идентификатор, Использование, Оповещение = Ложь, Модификатор = "")
	
	НоваяКоманда = Команды.Добавить();
	НоваяКоманда.Представление = Представление;
	НоваяКоманда.Идентификатор = Идентификатор;
	НоваяКоманда.Использование = Использование;
	НоваяКоманда.ПоказыватьОповещение = Оповещение;
	НоваяКоманда.Модификатор = Модификатор;
	
КонецПроцедуры

#КонецОбласти
