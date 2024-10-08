
&НаСервереБезКонтекста
Функция вЕстьПраваАдминистратора()
	Возврат ПравоДоступа("Администрирование", Метаданные);
КонецФункции

&НаСервереБезКонтекста
Функция вСкопироватьСтруктуру(Источник)
	Струк = новый Структура;
	
	Для каждого Элем из Источник Цикл
		Струк.Вставить(Элем.Ключ, Элем.Значение);
	КонецЦикла;
	
	Возврат Струк;
КонецФункции

&НаСервереБезКонтекста
Функция вПолучитьДанныеПоОбщимРеквизитам(АдресХранилища, Знач УникальныйИдентификатор)
	Попытка
		ТабРезультат = ПолучитьИзВременногоХранилища(АдресХранилища);
	Исключение
		ТабРезультат = Неопределено;
	КонецПопытки;
	
	Если ТабРезультат = Неопределено Тогда
		АдресХранилища = "";
	КонецЕсли;
	
	Если ТабРезультат = -1 или ТабРезультат = Неопределено или ТабРезультат.Колонки.Количество() = 0 Тогда
		ТабРезультат = новый ТаблицаЗначений;
		ТабРезультат.Колонки.Добавить("Имя", новый ОписаниеТипов("Строка"));
		ТабРезультат.Колонки.Добавить("Представление", новый ОписаниеТипов("Строка"));
		ТабРезультат.Колонки.Добавить("Тип", новый ОписаниеТипов("ОписаниеТипов"));
		ТабРезультат.Колонки.Добавить("Объект", новый ОписаниеТипов("Строка"));
		
		Для каждого пРеквизитМД из Метаданные.ОбщиеРеквизиты Цикл
			Если пРеквизитМД.РазделениеДанных = Метаданные.СвойстваОбъектов.РазделениеДанныхОбщегоРеквизита.Разделять Тогда
				Продолжить;
			КонецЕсли;
			
			пАвтоИспользование = (пРеквизитМД.АвтоИспользование = Метаданные.СвойстваОбъектов.АвтоИспользованиеОбщегоРеквизита.Использовать);
			
			Для каждого пЭлем из пРеквизитМД.Состав Цикл
				Если пАвтоИспользование Тогда
					пНадоБрать = (пЭлем.Использование <> Метаданные.СвойстваОбъектов.ИспользованиеОбщегоРеквизита.НеИспользовать);
				Иначе
					пНадоБрать = (пЭлем.Использование = Метаданные.СвойстваОбъектов.ИспользованиеОбщегоРеквизита.Использовать);
				КонецЕсли;
				
				Если пНадоБрать Тогда
					НС = ТабРезультат.Добавить();
					НС.Имя = пРеквизитМД.Имя;
					НС.Представление = пРеквизитМД.Представление();
					НС.Тип = пРеквизитМД.Тип;
					НС.Объект = пЭлем.Метаданные.ПолноеИмя();
				КонецЕсли;
			КонецЦикла;
		КонецЦикла;
		
		ТабРезультат.Индексы.Добавить("Объект");
		
		АдресХранилища = ПоместитьВоВременноеХранилище(ТабРезультат, ?(АдресХранилища = "", УникальныйИдентификатор, АдресХранилища));
	КонецЕсли;
	
	Возврат ТабРезультат;
КонецФункции

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Элементы.Список_ВыбратьОбъект.Видимость = Параметры.РежимВыбора;
	Элементы.СписокКонтекстноеМеню_ВыбратьОбъект.Видимость = Параметры.РежимВыбора;
	
	ТипХЗ = Тип("ХранилищеЗначения");
	
	Заголовок = Параметры.ПолноеИмя;
	ПутьКФормам = Параметры.ПутьКФормам;
	
	
	Если Параметры.Свойство("АдресаХранилищ") Тогда
		_АдресаХранилищ = вСкопироватьСтруктуру(Параметры.АдресаХранилищ);
	Иначе
		_АдресаХранилищ = новый Структура;
	КонецЕсли;
	
	Если не _АдресаХранилищ.Свойство("ОбщиеРеквизиты") Тогда
		_АдресаХранилищ.Вставить("ОбщиеРеквизиты", ПоместитьВоВременноеХранилище(-1, УникальныйИдентификатор));
	КонецЕсли;
	
	Список.ПроизвольныйЗапрос = ложь;
	Список.ОсновнаяТаблица = Параметры.ПолноеИмя;
	Список.ДинамическоеСчитываниеДанных = истина;
	
	Если не вЕстьПраваАдминистратора() Тогда
		Элементы.Список_УдалитьОбъекты.Видимость = ложь;
		Элементы.СписокКонтекстноеМеню_УдалитьОбъекты.Видимость = ложь;
	КонецЕсли;
	
	ОбъектМД = Метаданные.НайтиПоПолномуИмени(Параметры.ПолноеИмя);
	
	ОбъектОбработан = истина;
	Если Найти(Параметры.ПолноеИмя, "РегистрСведений") = 1 Тогда
		вОбработатьРегистр(ОбъектМД, ТипХЗ,истина);
	ИначеЕсли Найти(Параметры.ПолноеИмя, "РегистрНакопления") = 1 Тогда
		вОбработатьРегистр(ОбъектМД, ТипХЗ,,истина);
	ИначеЕсли Найти(Параметры.ПолноеИмя, "РегистрБухгалтерии") = 1 Тогда
		вОбработатьРегистр(ОбъектМД, ТипХЗ,,,истина);
	ИначеЕсли Найти(Параметры.ПолноеИмя, "РегистрРасчета") = 1 Тогда
		вОбработатьРегистр(ОбъектМД, ТипХЗ,,,,истина);
	Иначе
		ОбъектОбработан = ложь;
	КонецЕсли;
	
	Если ОбъектОбработан Тогда
		Элементы.Список_ОткрытьОбъект.Видимость = ложь;
		Элементы.Список_УдалитьОбъекты.Видимость = ложь;
		Элементы.СписокКонтекстноеМеню_ОткрытьОбъект.Видимость = ложь;
		Элементы.СписокКонтекстноеМеню_УдалитьОбъекты.Видимость = ложь;
		Возврат;
	КонецЕсли;
	
	ПереченьСвойств = "Иерархический, ВидИерархии, ДлинаКода, ДлинаНомера, ДлинаНаименования, ДлинаПорядка, Владельцы";
	СтрукСвойства = новый Структура(ПереченьСвойств);
	ЗаполнитьЗначенияСвойств(СтрукСвойства, ОбъектМД);
	
	МассивСтандартныхПолей = новый Массив;
	Если ЗначениеЗаполнено(СтрукСвойства.ДлинаНаименования) Тогда
		МассивСтандартныхПолей.Добавить("Наименование");
	КонецЕсли;
	Если СтрукСвойства.Владельцы <> Неопределено и СтрукСвойства.Владельцы.Количество() <> 0 Тогда
		МассивСтандартныхПолей.Добавить("Владелец");
	КонецЕсли;
	Если СтрукСвойства.ВидИерархии = Метаданные.СвойстваОбъектов.ВидИерархии.ИерархияГруппИЭлементов Тогда
		МассивСтандартныхПолей.Добавить("ЭтоГруппа");
	КонецЕсли;
	Если СтрукСвойства.Иерархический = истина Тогда
		МассивСтандартныхПолей.Добавить("Родитель");
	КонецЕсли;
	Если Найти(Параметры.ПолноеИмя, "Документ.") = 1 Тогда
		МассивСтандартныхПолей.Добавить("Дата");
	КонецЕсли;
	Если ЗначениеЗаполнено(СтрукСвойства.ДлинаКода) Тогда
		МассивСтандартныхПолей.Добавить("Код");
	КонецЕсли;
	Если ЗначениеЗаполнено(СтрукСвойства.ДлинаНомера) Тогда
		МассивСтандартныхПолей.Добавить("Номер");
	КонецЕсли;
	Если ЗначениеЗаполнено(СтрукСвойства.ДлинаПорядка) Тогда
		МассивСтандартныхПолей.Добавить("Порядок");
	КонецЕсли;
	
	Для каждого Элем из МассивСтандартныхПолей Цикл
		Попытка
			ЭФ = Элементы.Добавить("Список_" + Элем,  Тип("ПолеФормы"), Элементы.Список);
			ЭФ.Вид = ВидПоляФормы.ПолеВвода;
			ЭФ.ПутьКДанным = "Список." + Элем;
		Исключение
			Элементы.Удалить(ЭФ);
		КонецПопытки;
	КонецЦикла;
	
	ТабРеквизиты = новый ТаблицаЗначений;
	ТабРеквизиты.Колонки.Добавить("Имя", новый ОписаниеТипов("Строка"));
	
	Если Найти(Параметры.ПолноеИмя, "ЖурналДокументов") = 1 Тогда
		Для каждого Элем из ОбъектМД.Графы Цикл
			Для каждого пСсылка из Элем.Ссылки Цикл
				Если не пСсылка.Тип.СодержитТип(ТипХЗ) Тогда
					НС = ТабРеквизиты.Добавить();
					НС.Имя = Элем.Имя;
				КонецЕсли;
				Прервать;
			КонецЦикла;
		КонецЦикла;
		ТабРеквизиты.Сортировать("Имя");
		
		ТабРеквизиты.Вставить(0).Имя = "Тип";
		ТабРеквизиты.Вставить(0).Имя = "Дата";
		ТабРеквизиты.Вставить(0).Имя = "Номер";
		
	Иначе
		пТабОбщиеРеквизиты = вПолучитьДанныеПоОбщимРеквизитам(_АдресаХранилищ.ОбщиеРеквизиты, УникальныйИдентификатор).НайтиСтроки(новый Структура("Объект", Параметры.ПолноеИмя));
		Для каждого Элем из пТабОбщиеРеквизиты Цикл
			Если не Элем.Тип.СодержитТип(ТипХЗ) Тогда
				НС = ТабРеквизиты.Добавить();
				НС.Имя = Элем.Имя;
			КонецЕсли;
		КонецЦикла;
		
		Для каждого Элем из ОбъектМД.Реквизиты Цикл
			Если не Элем.Тип.СодержитТип(ТипХЗ) Тогда
				НС = ТабРеквизиты.Добавить();
				НС.Имя = Элем.Имя;
			КонецЕсли;
		КонецЦикла;
		ТабРеквизиты.Сортировать("Имя");
	КонецЕсли;
	
	
	Для каждого Элем из ТабРеквизиты Цикл
		Попытка
			ЭФ = Элементы.Добавить("Список_" + Элем.Имя,  Тип("ПолеФормы"), Элементы.Список);
			ЭФ.Вид = ВидПоляФормы.ПолеВвода;
			ЭФ.ПутьКДанным = "Список." + Элем.Имя;
			Если истина Тогда
				ЭФ.Заголовок = Элем.Имя;
			КонецЕсли;
		Исключение
			Элементы.Удалить(ЭФ);
		КонецПопытки;
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура вОбработатьРегистр(ОбъектМД, ТипХЗ, ЭтоРС = ложь, ЭтоРН = ложь, ЭтоРБ = ложь, ЭтоРР = ложь)
	СтрукРазделы = новый Структура("Измерения, Ресурсы, Реквизиты");
	
	ЕстьКорреспонденция = ЭтоРБ и ОбъектМД.Корреспонденция;
	
	МассивСтандартныхПолей = новый Массив;
	Если ЭтоРС Тогда
		МассивСтандартныхПолей.Добавить("Активность");
		Если ОбъектМД.ПериодичностьРегистраСведений <> Метаданные.СвойстваОбъектов.ПериодичностьРегистраСведений.Непериодический Тогда
			МассивСтандартныхПолей.Добавить("Период");
		КонецЕсли;
		Если ОбъектМД.РежимЗаписи <> Метаданные.СвойстваОбъектов.РежимЗаписиРегистра.Независимый Тогда
			МассивСтандартныхПолей.Добавить("Регистратор");
		КонецЕсли;
	ИначеЕсли ЭтоРН Тогда
		Если ОбъектМД.ВидРегистра = Метаданные.СвойстваОбъектов.ВидРегистраНакопления.Остатки Тогда
			МассивСтандартныхПолей.Добавить("ВидДвижения");
		КонецЕсли;
		МассивСтандартныхПолей.Добавить("Активность");
		МассивСтандартныхПолей.Добавить("Период");
		МассивСтандартныхПолей.Добавить("Регистратор");
	ИначеЕсли ЭтоРБ Тогда
		Если не ЕстьКорреспонденция Тогда
			МассивСтандартныхПолей.Добавить("ВидДвижения");
		КонецЕсли;
		МассивСтандартныхПолей.Добавить("Активность");
		МассивСтандартныхПолей.Добавить("Период");
		МассивСтандартныхПолей.Добавить("Регистратор");
		Если ЕстьКорреспонденция Тогда
			МассивСтандартныхПолей.Добавить("СчетДт");
			МассивСтандартныхПолей.Добавить("СчетКт");
		Иначе
			МассивСтандартныхПолей.Добавить("Счет");
		КонецЕсли;
	ИначеЕсли ЭтоРР Тогда
		МассивСтандартныхПолей.Добавить("Активность");
		МассивСтандартныхПолей.Добавить("ВидРасчета");
		МассивСтандартныхПолей.Добавить("ПериодРегистрации");
		МассивСтандартныхПолей.Добавить("Регистратор");
		
		Если ОбъектМД.БазовыйПериод Тогда
			МассивСтандартныхПолей.Добавить("БазовыйПериодНачало");
			МассивСтандартныхПолей.Добавить("БазовыйПериодКонец");
		КонецЕсли;
		
		Если ОбъектМД.ПериодДействия Тогда
			МассивСтандартныхПолей.Добавить("ПериодДействия");
			МассивСтандартныхПолей.Добавить("ПериодДействияНачало");
			МассивСтандартныхПолей.Добавить("ПериодДействияКонец");
		КонецЕсли;
	КонецЕсли;
	
	Для каждого Элем из МассивСтандартныхПолей Цикл
		Попытка
			ЭФ = Элементы.Добавить("Список_" + Элем,  Тип("ПолеФормы"), Элементы.Список);
			ЭФ.Вид = ВидПоляФормы.ПолеВвода;
			ЭФ.ПутьКДанным = "Список." + Элем;
		Исключение
			Элементы.Удалить(ЭФ);
		КонецПопытки;
	КонецЦикла;
	
	Для каждого Раздел из СтрукРазделы Цикл
		Для каждого Элем из ОбъектМД[Раздел.Ключ] Цикл
			Если не Элем.Тип.СодержитТип(ТипХЗ) Тогда
				Попытка
					Если ЕстьКорреспонденция и (Раздел.Ключ = "Измерения" или Раздел.Ключ = "Ресурсы") и не Элем.Балансовый Тогда
						ЭФ = Элементы.Добавить("Список_" + Элем.Имя + "Дт",  Тип("ПолеФормы"), Элементы.Список);
						ЭФ.Вид = ВидПоляФормы.ПолеВвода;
						ЭФ.ПутьКДанным = "Список." + Элем.Имя + "Дт";
						
						ЭФ = Элементы.Добавить("Список_" + Элем.Имя + "Кт",  Тип("ПолеФормы"), Элементы.Список);
						ЭФ.Вид = ВидПоляФормы.ПолеВвода;
						ЭФ.ПутьКДанным = "Список." + Элем.Имя + "Кт";
					Иначе
						ЭФ = Элементы.Добавить("Список_" + Элем.Имя,  Тип("ПолеФормы"), Элементы.Список);
						ЭФ.Вид = ВидПоляФормы.ПолеВвода;
						ЭФ.ПутьКДанным = "Список." + Элем.Имя;
					КонецЕсли;
				Исключение
					Элементы.Удалить(ЭФ);
				КонецПопытки;
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
	
	пТабОбщиеРеквизиты = вПолучитьДанныеПоОбщимРеквизитам(_АдресаХранилищ.ОбщиеРеквизиты, УникальныйИдентификатор).НайтиСтроки(новый Структура("Объект", ОбъектМД.ПолноеИмя()));
	Для каждого Элем из пТабОбщиеРеквизиты Цикл
		Если не Элем.Тип.СодержитТип(ТипХЗ) Тогда
			Попытка
				ЭФ = Элементы.Добавить("Список_" + Элем.Имя,  Тип("ПолеФормы"), Элементы.Список);
				ЭФ.Вид = ВидПоляФормы.ПолеВвода;
				ЭФ.ПутьКДанным = "Список." + Элем.Имя;
			Исключение
				Элементы.Удалить(ЭФ);
			КонецПопытки;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура _ОткрытьОбъект(Команда)
	ТекДанные = Элементы.Список.ТекущаяСтрока;
	Если ТекДанные <> Неопределено Тогда
		Значение = ТекДанные;
		
		СтрукПарам = новый Структура("мОбъектСсылка, АдресаХранилищ", Значение, _АдресаХранилищ);
		ОткрытьФорму(ПутьКФормам + "ФормаОбъекта", СтрукПарам, ,Значение);
	КонецЕсли;
КонецПроцедуры


&НаКлиенте
Процедура _УдалитьОбъекты(Команда)
	МассивСсылок = новый Массив;
	
	Для каждого Элем из Элементы.Список.ВыделенныеСтроки Цикл
		МассивСсылок.Добавить(Элем);
	КонецЦикла;
	
	ЧислоЭлементов = МассивСсылок.Количество();
	
	Если ЧислоЭлементов = 0 Тогда
		Возврат;
	ИначеЕсли ЧислоЭлементов = 1 Тогда
		ТекстВопроса = "Объект будет удален из базы!
		|Никакие проверки производиться не будут (возможно появление битых ссылок)!
		|
		|Продолжить?";
	Иначе
		ТекстВопроса = "Объекты (" + ЧислоЭлементов + " шт) будут удалены из базы!
		|Никакие проверки производиться не будут (возможно появление битых ссылок)!
		|
		|Продолжить?";
	КонецЕсли;
	
	ПоказатьВопрос(новый ОписаниеОповещения("вУдалитьОбъекты", ЭтаФорма, МассивСсылок), ТекстВопроса, РежимДиалогаВопрос.ДаНетОтмена, 20,,"ВНИМАНИЕ");
КонецПроцедуры

&НаКлиенте
Процедура вУдалитьОбъекты(РезультатВопроса, МассивСсылок) Экспорт
	Если РезультатВопроса = КодВозвратаДиалога.Да Тогда
		Для каждого Ссылка из МассивСсылок Цикл
			вУдалитьОбъектНаСервере(Ссылка);
		КонецЦикла;
		Элементы.Список.Обновить();
	КонецЕсли;
КонецПроцедуры

&НаСервереБезКонтекста
Процедура вУдалитьОбъектНаСервере(Ссылка)
	Попытка
		пОбъект = Ссылка.ПолучитьОбъект();
		Если пОбъект = Неопределено Тогда
			Возврат;
		КонецЕсли;
		пОбъект.Удалить();
	Исключение
		Сообщить("Ошибка при удалении объекта:" + Символы.ПС + ОписаниеОшибки());
	КонецПопытки;
КонецПроцедуры


&НаКлиенте
Процедура _ВыбратьОбъект(Команда)
	Если Параметры.РежимВыбора Тогда
		ТекДанные = Элементы.Список.ТекущаяСтрока;
		Если ТекДанные <> Неопределено Тогда
			ОповеститьОВыборе(ТекДанные);
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	Если Параметры.РежимВыбора Тогда
		СтандартнаяОбработка = ложь;
		ОповеститьОВыборе(ВыбраннаяСтрока);
	КонецЕсли;
КонецПроцедуры
