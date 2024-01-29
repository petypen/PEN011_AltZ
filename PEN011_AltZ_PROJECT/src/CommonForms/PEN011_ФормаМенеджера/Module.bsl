// @strict-types
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	//@skip-check using-isinrole - тут нужна проверка именно на роль
	Если РольДоступна("ПолныеПрава") Тогда
		ИсследуемыйОбъект = Параметры.ИсследуемыйОбъект;
	Иначе
		Отказ = Истина;
		Возврат;
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ДекорацияИсследоватьОбъектНажатие(Элемент)

	ПараметрыФормы = Новый Структура();
	ПараметрыФормы.Вставить("мОбъектСсылка", ИсследуемыйОбъект);
	ОткрытьФорму("Обработка.PEN011_РедакторОбъекта.Форма.ФормаОбъекта", ПараметрыФормы);

	Закрыть();
КонецПроцедуры

&НаКлиенте
Процедура ДекорацияКонсольЗапросовНажатие(Элемент)

	ПараметрыФормы = Новый Структура();
	ОткрытьФорму("Обработка.PEN011_КонсольЗапросов9000.Форма.Форма", ПараметрыФормы);

	Закрыть();
КонецПроцедуры

&НаКлиенте
Процедура ДекорацияКонсольКодаНажатие(Элемент)

	ПараметрыФормы = Новый Структура();
	ОткрытьФорму("Обработка.PEN011_КонсольКода.Форма.Форма", ПараметрыФормы);

	Закрыть();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Команда1(Команда)

	ПараметрыФормы = Новый Структура();
	ПараметрыФормы.Вставить("мОбъектСсылка", ИсследуемыйОбъект);

	ОткрытьФорму("Обработка.PEN011_РедакторОбъекта.Форма.ФормаОбъекта", ПараметрыФормы);

КонецПроцедуры

#КонецОбласти