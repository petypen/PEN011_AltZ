// @strict-types
#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	// Активное окно

	ОкноПриложения = АктивноеОкно();

	Если ОкноПриложения = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	// Исследуемый объект

	ИсследуемыйОбъект = Неопределено; // Произвольный - любой тип объекта
	ИсследуемыйОбъект = ИсследуемыйОбъект(ОкноПриложения);

	// Форма менеджера ИР

	ПараметрыФормы = Новый Структура("ИсследуемыйОбъект", ИсследуемыйОбъект);
	ОткрытьФорму("ОбщаяФорма.PEN011_ФормаМенеджера", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник,
		ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно,
		ПараметрыВыполненияКоманды.НавигационнаяСсылка);

КонецПроцедуры

#КонецОбласти


#Область СлужебныеПроцедурыИФункции

// Ссылка на Исследуемый объект активного окна.
// 
// Параметры:
//  ОкноПриложения - ОкноКлиентскогоПриложения, Неопределено - Окно приложения, в котором открыт исследуемый объект
// 
// Возвращаемое значение:
//  Неопределено, Произвольный - Ссылка на Исследуемый объект активного окна
&НаКлиенте
Функция ИсследуемыйОбъект(ОкноПриложения)

	ИсследуемыйОбъект = Неопределено;

	Форма = ОкноПриложения.Содержимое[0]; // ФормаКлиентскогоПриложения - 

	Если ТипЗнч(Форма.ТекущийЭлемент) = Тип("ТаблицаФормы") Тогда
		ИсследуемыйОбъект = ОбъектИзФормыСписка(Форма);
	Иначе
		ИсследуемыйОбъект = ОбъектИзФормыОбъекта(ОкноПриложения);
	КонецЕсли;

	Возврат ИсследуемыйОбъект;
КонецФункции

&НаКлиенте
Функция ОбъектИзФормыОбъекта(ОкноПриложения)

	ИсследуемыйОбъект = СсылкаИзНавигационной(ОкноПриложения.ПолучитьНавигационнуюСсылку());

	Если Не ЗначениеЗаполнено(ИсследуемыйОбъект) Тогда
		ИсследуемыйОбъект = Неопределено;
	КонецЕсли;

	Возврат ИсследуемыйОбъект;
КонецФункции

&НаКлиенте
Функция ОбъектИзФормыСписка(Форма)

	ИсследуемыйОбъект = Форма.ТекущийЭлемент.ТекущаяСтрока;

	Если Не ЗначениеЗаполнено(ИсследуемыйОбъект) Тогда
		ИсследуемыйОбъект = Неопределено;
	КонецЕсли;

	Возврат ИсследуемыйОбъект;
КонецФункции

// Получить ссылку из навигационной.
// 
// Параметры:
//  НавигационнаяСсылка - Строка - Навигационная ссылка
// 
// Возвращаемое значение:
//  ЛюбаяСсылка - Получить ссылку из навигационной
&НаСервере
Функция СсылкаИзНавигационной(НавигационнаяСсылка)

	ПерваяТочка = СтрНайти(НавигационнаяСсылка, "e1cib/data/");
	ВтораяТочка = СтрНайти(НавигационнаяСсылка, "?ref=");

	ПредставлениеТипа = Сред(НавигационнаяСсылка, ПерваяТочка + 11, ВтораяТочка - ПерваяТочка - 11);
	ШаблонЗначения = ЗначениеВСтрокуВнутр(ПредопределенноеЗначение(ПредставлениеТипа + ".ПустаяСсылка"));
	ЗначениеСсылки = СтрЗаменить(ШаблонЗначения, "00000000000000000000000000000000", Сред(НавигационнаяСсылка,
		ВтораяТочка + 5));

	Возврат ЗначениеИзСтрокиВнутр(ЗначениеСсылки);
КонецФункции

#КонецОбласти