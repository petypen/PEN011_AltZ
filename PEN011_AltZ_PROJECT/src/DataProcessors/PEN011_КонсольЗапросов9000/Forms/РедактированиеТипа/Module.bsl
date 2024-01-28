
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	КопироватьДанныеФормы(Параметры.Объект, Объект);
	
	Параметры.Свойство("ВЗапросРазрешено", ВЗапросРазрешено);
	Параметры.Свойство("ИмяПараметра", ИмяПараметра);
	
	дзДеревоТипов = Неопределено;
	
	ТипЗначения = Параметры.ТипЗначения;
	
	Параметры.Свойство("СписокРазрешенных", СписокРазрешенных);
	
	Если НЕ Параметры.Свойство("ВПараметр", РежимВПараметр) Тогда
		РежимВПараметр = Ложь;
	КонецЕсли;
	
	Если РежимВПараметр Тогда
		РежимСтрокой = "В параметр";
		Элементы.КомандаОК.Заголовок = РежимСтрокой;
	Иначе
		РежимСтрокой = "Редактирование типа";
	КонецЕсли;
	
	Если Параметры.Свойство("Имя", ИмяПараметра) Тогда
		Заголовок = СтрШаблон("%1 (%2)", ИмяПараметра, НРег(РежимСтрокой));
	Иначе
		Заголовок = РежимСтрокой;
		ИмяПараметра = "ТаблицаЗначений";
	КонецЕсли;
	
	Если ТипЗнч(ТипЗначения) = Тип("Структура") И ТипЗначения.Тип = "Тип" Тогда

		Попытка
			маТипы = Новый Массив;
			маТипы.Добавить(РеквизитФормыВЗначение("Объект").Контейнер_ВосстановитьЗначение(ТипЗначения));
			ТипЗначения = Новый ОписаниеТипов(маТипы);
		Исключение
			ТипЗначения = Новый ОписаниеТипов;
		КонецПопытки;
		
		фПростойВид = Истина;
		фРедактированиеТипа = Истина;
		Элементы.СоставнойТип.Видимость = Ложь;
		Элементы.Контейнер.Видимость = Ложь;
		Элементы.ГруппаКвалификаторыДаты.Видимость = Ложь;
		Элементы.ГруппаКвалификаторыЧисла.Видимость = Ложь;
		Элементы.ГруппаКвалификаторыСтроки.Видимость = Ложь;
		
	ИначеЕсли ТипЗнч(ТипЗначения) = Тип("Тип") Тогда
		
		маТипы = Новый Массив;
		маТипы.Добавить(ТипЗначения);
		ТипЗначения = Новый ОписаниеТипов(маТипы);
			
		фПростойВид = Истина;
		фРедактированиеТипа = Истина;
		Элементы.СоставнойТип.Видимость = Ложь;
		Элементы.Контейнер.Видимость = Ложь;
		Элементы.ГруппаКвалификаторыДаты.Видимость = Ложь;
		Элементы.ГруппаКвалификаторыЧисла.Видимость = Ложь;
		Элементы.ГруппаКвалификаторыСтроки.Видимость = Ложь;
		
	Иначе
	
		Если НЕ ЗначениеЗаполнено(ТипЗначения) Тогда
			ТипЗначения = Новый ОписаниеТипов;
		КонецЕсли;
		
		ТипКонтейнера = Неопределено;
		фПростойВид = НЕ Параметры.Свойство("ТипКонтейнера", ТипКонтейнера);
		
		Если фПростойВид Тогда
			ТипКонтейнера = 0;
			Элементы.Контейнер.Видимость = Ложь;
		КонецЕсли;
		
		Если ТипКонтейнера = 3 Тогда
			
			//Режим редактирования структуры таблицы. Таблицу можно передать с данными, они будут сохранены.
			Таблица = РеквизитФормыВЗначение("Объект").СтрокаВЗначение(ТипЗначения.Значение);
			
			//Сами данные на клиента не потащим.
			АдресТаблицы = ПоместитьВоВременноеХранилище(Таблица, УникальныйИдентификатор);
			
			ЗаполнитьСтруктуруТаблицы(Таблица);
			ТипЗначения = Новый ОписаниеТипов;
			
		КонецЕсли;
		
	КонецЕсли;
		
	СоставнойТип = ТипЗначения.Типы().Количество() > 1;
	
	КвалификаторыДатыСостав = ТипЗначения.КвалификаторыДаты.ЧастиДаты;
	КвалификаторыСтрокиДлина = ТипЗначения;
	КвалификаторыСтрокиФиксированная = ТипЗначения.КвалификаторыСтроки.ДопустимаяДлина = ДопустимаяДлина.Фиксированная;
	КвалификаторыЧислаДлина = ТипЗначения.КвалификаторыЧисла.Разрядность;
	КвалификаторыЧислаНеОтрицательный = ТипЗначения.КвалификаторыЧисла.ДопустимыйЗнак = ДопустимыйЗнак.Неотрицательный;
	КвалификаторыЧислаТочность = ТипЗначения.КвалификаторыЧисла.РазрядностьДробнойЧасти;
	
	дзДеревоТипов = ПолучитьДеревоТипов(ТипЗначения, СписокРазрешенных);
	Если НЕ СоставнойТип И ТипКонтейнера = 0 Тогда
		ДобавитьМоментИГраницуВДерево(дзДеревоТипов, ТипЗначения);
	КонецЕсли;
	
	ДеревоТипов = ПоместитьВоВременноеХранилище(дзДеревоТипов, УникальныйИдентификатор);
	ОбновитьСоставТипаНаСервере();
	
	УстановитьВидимостьЭлементов();
	
	ТекущийЭлемент = Элементы.СтрокаПоиска;

КонецПроцедуры

&НаСервере
Процедура ДеревоТиповВДанныеФормы(Узел, УзелРеквизита, ТекущаяСтрока = Неопределено, ВыбранПодч = Ложь)
	
	ЭлементыУзла = УзелРеквизита.ПолучитьЭлементы();
	
	Для Каждого Строка Из Узел.Строки Цикл
		
		Если Строка.Строки.Количество() > 0 Тогда
			
			СтрокаРеквизита = ЭлементыУзла.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаРеквизита, Строка);
			СтрокаРеквизита.ВыбранПодч = Ложь;
			ДеревоТиповВДанныеФормы(Строка, СтрокаРеквизита, ТекущаяСтрока, СтрокаРеквизита.ВыбранПодч);
			
			Если СтрокаРеквизита.ПолучитьЭлементы().Количество() = 0 Тогда
				ЭлементыУзла.Удалить(СтрокаРеквизита);
			КонецЕсли;
			
		Иначе
			
			Если НЕ ЗначениеЗаполнено(СтрокаПоиска)
					ИЛИ Найти(ВРег(Строка.Представление), ВРег(СтрокаПоиска)) > 0
					//ИЛИ Найти(ВРег(Строка.Имя), ВРег(СтрокаПоиска)) > 0
						Тогда
				СтрокаРеквизита = ЭлементыУзла.Добавить();
				ЗаполнитьЗначенияСвойств(СтрокаРеквизита, Строка);
				ВыбранПодч = ВыбранПодч ИЛИ Строка.Выбран;
			КонецЕсли;
			
		КонецЕсли;
		
		Если ТекущаяСтрока = Неопределено И СтрокаРеквизита <> Неопределено И Строка.Выбран Тогда
			ТекущаяСтрока = СтрокаРеквизита.ПолучитьИдентификатор();
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьОтметкиДерева(УзелДерева, УзелСоставаТипа)
	Перем ЭлементыУзла;
	
	Если УзелСоставаТипа <> Неопределено Тогда
		ЭлементыУзла = УзелСоставаТипа.ПолучитьЭлементы();
	КонецЕсли;
	
	й = 0;
	Для Каждого СтрокаДерева Из УзелДерева.Строки Цикл
		
		Если ЭлементыУзла = Неопределено ИЛИ ЭлементыУзла.Количество() <= й Тогда
			Если ФлагСброшеныВсе Тогда
				СтрокаДерева.Выбран = Ложь;
				Если СтрокаДерева.Строки.Количество() > 0 Тогда
					ОбновитьОтметкиДерева(СтрокаДерева, Неопределено);
				КонецЕсли;
				Продолжить;
			Иначе
				Прервать;
			КонецЕсли;
		КонецЕсли;
		
		Если ФлагСброшеныВсе Тогда
			СтрокаДерева.Выбран = Ложь;
		КонецЕсли;
		
		Если ЭлементыУзла[й].Имя = СтрокаДерева.Имя Тогда
			
			СтрокаДерева.Выбран = ЭлементыУзла[й].Выбран;
			
			Если СтрокаДерева.Строки.Количество() > 0 Тогда
				ОбновитьОтметкиДерева(СтрокаДерева, ЭлементыУзла[й]);
			КонецЕсли;
			
			й = й + 1;
			
		КонецЕсли;
		
	КонецЦикла;
	
	ФлагСброшеныВсе = Ложь;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьСоставТипаНаСервере()
	
	дзДерево = ПолучитьИзВременногоХранилища(ДеревоТипов);
	ОбновитьОтметкиДерева(дзДерево, СоставТипа);
	ПоместитьВоВременноеХранилище(дзДерево, ДеревоТипов);
	
	ТекущаяСтрока = Неопределено;
	СоставТипа.ПолучитьЭлементы().Очистить();
	ДеревоТиповВДанныеФормы(дзДерево, СоставТипа, ТекущаяСтрока);
	Элементы.СоставТипа.ТекущаяСтрока = ТекущаяСтрока;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьСостояниеДереваТипов()
	Если ЗначениеЗаполнено(СтрокаПоиска) Тогда
		Для Каждого Элемент Из СоставТипа.ПолучитьЭлементы() Цикл
			Элементы.СоставТипа.Развернуть(Элемент.ПолучитьИдентификатор(), Истина);
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьСоставТипа() Экспорт
	ОбновитьСоставТипаНаСервере();
	УстановитьСостояниеДереваТипов();
КонецПроцедуры

&НаСервере
Функция ПолучитьПредставлениеКвалификаторовТипа(ТипЗначения)

	маКвалификаторы = Новый Массив;
	
	Если ТипЗначения.СодержитТип(Тип("Строка")) Тогда
		ПредставлениеКвалификаторовСтроки = "Длина " + ТипЗначения.КвалификаторыСтроки.Длина;
		маКвалификаторы.Добавить(Новый Структура("Тип, Квалификаторы", "Строка", ПредставлениеКвалификаторовСтроки));
	КонецЕсли;
		
	Если ТипЗначения.СодержитТип(Тип("Дата")) Тогда
		ПредставлениеКвалификаторовДаты = ТипЗначения.КвалификаторыДаты.ЧастиДаты;
		маКвалификаторы.Добавить(Новый Структура("Тип, Квалификаторы", "Дата", ПредставлениеКвалификаторовДаты));
	КонецЕсли;
	
	Если ТипЗначения.СодержитТип(Тип("Число")) Тогда
		ПредставлениеКвалификаторовЧисла =
			"Знак " + ТипЗначения.КвалификаторыЧисла.ДопустимыйЗнак + " " +
			ТипЗначения.КвалификаторыЧисла.Разрядность + "." + ТипЗначения.КвалификаторыЧисла.РазрядностьДробнойЧасти;
		маКвалификаторы.Добавить(Новый Структура("Тип, Квалификаторы", "Число", ПредставлениеКвалификаторовЧисла));
	КонецЕсли;
	
	ФлагНуженЗаголовок = маКвалификаторы.Количество() > 1;
	
	ПредставлениеКвалификаторовТипа = "";
	Для Каждого стКвалификаторы Из маКвалификаторы Цикл
		ПредставлениеКвалификаторовТипа = ПредставлениеКвалификаторовТипа + ?(ФлагНуженЗаголовок, стКвалификаторы.Тип + ": ", "") + стКвалификаторы.Квалификаторы + "; ";
	КонецЦикла;
	
	Возврат ПредставлениеКвалификаторовТипа;
	
КонецФункции

&НаСервере
Процедура ЗаполнитьСтруктуруТаблицы(Таблица)
	
	Для Каждого Колонка Из Таблица.Колонки Цикл
		СтрокаСтруктуры = СтруктураТаблицы.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаСтруктуры, Колонка, "Имя, ТипЗначения");
		СтрокаСтруктуры.ИмяСтарое = Колонка.Имя;
		СтрокаСтруктуры.Квалификаторы = ПолучитьПредставлениеКвалификаторовТипа(Колонка.ТипЗначения);
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьПервыйВыбранный(СоставТипа)
	
	Для Каждого СтрокаТипа Из СоставТипа.ПолучитьЭлементы() Цикл
		Если СтрокаТипа.ЭтоГруппа Тогда
			Результат = ПолучитьПервыйВыбранный(СтрокаТипа);
			Если Результат <> Неопределено Тогда
				Возврат Результат;
			КонецЕсли;
		Иначе
			Если СтрокаТипа.Выбран Тогда
				Возврат СтрокаТипа.Имя;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции

&НаСервере
Функция СобратьТипы(СоставТипа, маТипы = Неопределено)
	
	Если маТипы = Неопределено Тогда
		маТипы = Новый Массив;
	КонецЕсли;
	
	Для Каждого СтрокаТипа Из СоставТипа.Строки Цикл
		Если СтрокаТипа.ЭтоГруппа Тогда
			маТипы = СобратьТипы(СтрокаТипа, маТипы);
		Иначе
			Если СтрокаТипа.Выбран Тогда
				маТипы.Добавить(Тип(СтрокаТипа.Имя));
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Возврат маТипы;
	
КонецФункции

&НаСервере
Функция ПолучитьОписаниеТипов()
	
	дзДерево = ПолучитьИзВременногоХранилища(ДеревоТипов);
	ОбновитьОтметкиДерева(дзДерево, СоставТипа);
	маТипы = СобратьТипы(дзДерево);
	
	КвалификаторыЧисла = Новый КвалификаторыЧисла(КвалификаторыЧислаДлина, КвалификаторыЧислаТочность, ?(КвалификаторыЧислаНеОтрицательный, ДопустимыйЗнак.Неотрицательный, ДопустимыйЗнак.Любой));
	КвалификаторыСтроки = Новый КвалификаторыСтроки(КвалификаторыСтрокиДлина, ?(КвалификаторыСтрокиФиксированная, ДопустимаяДлина.Фиксированная, ДопустимаяДлина.Переменная));
	КвалификаторыДаты = Новый КвалификаторыДаты(?(КвалификаторыДатыСостав = "Дата и время", ЧастиДаты.ДатаВремя, ЧастиДаты[КвалификаторыДатыСостав]));
	
	Возврат Новый ОписаниеТипов(маТипы, КвалификаторыЧисла, КвалификаторыСтроки, КвалификаторыДаты);
	
КонецФункции

&НаСервере
Функция ПолучитьКонтейнерТипа(ОписаниеТипов)
	
	Обработка = РеквизитФормыВЗначение("Объект");
	ВозвращаемыйТип = Тип("Неопределено");
	
	маТипы = ОписаниеТипов.Типы();
	Если маТипы.Количество() > 0 Тогда
		ВозвращаемыйТип = маТипы[0];
	КонецЕсли;
	
	Возврат Обработка.Контейнер_СохранитьЗначение(ВозвращаемыйТип);
	
КонецФункции

&НаСервере
Функция ПолучитьТаблицу(ТекстЗапроса = Неопределено)
	
	Обработка = РеквизитФормыВЗначение("Объект");
	
	фЕстьИзмененияКолонок = Ложь;
	стСоответствиеКолонок = Новый Структура;
	маВыраженияКолонок  = Новый Массив;
	Таблица = Новый ТаблицаЗначений;
	Для Каждого СтрокаСтруктуры Из СтруктураТаблицы Цикл
		
		Колонка = Таблица.Колонки.Добавить(СтрокаСтруктуры.Имя, СтрокаСтруктуры.ТипЗначения);
		
		маВыраженияКолонок.Добавить(СтрШаблон("	%1.%2 КАК %2", ИмяПараметра, Колонка.Имя));
		
		Если ЗначениеЗаполнено(СтрокаСтруктуры.ИмяСтарое) Тогда
			стСоответствиеКолонок.Вставить(СтрокаСтруктуры.Имя, СтрокаСтруктуры.ИмяСтарое);
			фЕстьИзмененияКолонок = фЕстьИзмененияКолонок ИЛИ СтрокаСтруктуры.ИмяСтарое <> СтрокаСтруктуры.Имя;
		КонецЕсли;
			
	КонецЦикла;
	
	Если стСоответствиеКолонок.Количество() > 0 Тогда
		
		СтараяТаблица = ПолучитьИзВременногоХранилища(АдресТаблицы);
		
		Если фЕстьИзмененияКолонок Тогда
			
			Для Каждого Строка Из СтараяТаблица Цикл
				СтрокаНовая = Таблица.Добавить();
				Для Каждого кз Из стСоответствиеКолонок Цикл
					СтрокаНовая[кз.Ключ] = Строка[кз.Значение];
				КонецЦикла;
			КонецЦикла;
			
		Иначе
			Для Каждого Строка Из СтараяТаблица Цикл
				ЗаполнитьЗначенияСвойств(Таблица.Добавить(), Строка);
			КонецЦикла;
		КонецЕсли;
		
	КонецЕсли;

	ВыраженияКолонок = СтрСоединить(маВыраженияКолонок, ",
		|");
	ТекстЗапроса = СтрШаблон("
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		| %1
		|ПОМЕСТИТЬ %2
		|ИЗ &%2 КАК %2;",
		ВыраженияКолонок,
		ИмяПараметра);
		
	Возврат Обработка.Контейнер_СохранитьЗначение(Таблица);
		
КонецФункции

&НаКлиенте
Функция ПолноеИмяФормы(ИмяФормы)
	Возврат СтрШаблон("%1.Форма.%2", Объект.ПутьМетаданных, ИмяФормы);
КонецФункции

&НаКлиенте
Процедура КомандаОК(Команда)
	
	ВозвращаемоеЗначение = Новый Структура("ИмяПараметра, ТипКонтейнера, ОписаниеКонтейнера", ИмяПараметра, ТипКонтейнера, ПолучитьОписаниеТипов());
	
	Если ТипКонтейнера < 3 Тогда
		
		Если фРедактированиеТипа Тогда
			ВозвращаемоеЗначение.ОписаниеКонтейнера = ПолучитьКонтейнерТипа(ВозвращаемоеЗначение.ОписаниеКонтейнера);
		ИначеЕсли ВозвращаемоеЗначение.ОписаниеКонтейнера.СодержитТип(Тип("Граница")) ИЛИ ВозвращаемоеЗначение.ОписаниеКонтейнера.СодержитТип(Тип("МоментВремени")) Тогда
			ВозвращаемоеЗначение.ТипКонтейнера = 0;
		КонецЕсли;
		
	Иначе
		
		ВозвращаемоеЗначение.ОписаниеКонтейнера = ПолучитьТаблицу();
		
	КонецЕсли;
	
	Закрыть(ВозвращаемоеЗначение);
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаВЗапрос(Команда)
	Перем ТекстЗапроса;
	
	ВозвращаемоеЗначение = Новый Структура("ИмяПараметра, ТипКонтейнера, ОписаниеКонтейнера, ТекстЗапроса", ИмяПараметра, ТипКонтейнера, ПолучитьОписаниеТипов());
	ВозвращаемоеЗначение.ОписаниеКонтейнера = ПолучитьТаблицу(ТекстЗапроса);
	ВозвращаемоеЗначение.ТекстЗапроса = ТекстЗапроса;
	
	Закрыть(ВозвращаемоеЗначение);
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьМоментИГраницуВДерево(дзДерево, ТипЗначенияТекущий = Неопределено)
	Перем Картинки;
	
	Если ТипЗначенияТекущий = Неопределено Тогда
		ТипЗначенияТекущий = Новый ОписаниеТипов;
	КонецЕсли;
	
	ДобавитьТип(дзДерево, ТипЗначенияТекущий, "Граница", Картинки, "Граница", 4);
	ДобавитьТип(дзДерево, ТипЗначенияТекущий, "МоментВремени", Картинки, "Момент времени", 5);
	
	фМоментГраница = Истина;
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьМоментИГраницу()
	
	дзДерево = ПолучитьИзВременногоХранилища(ДеревоТипов);
	ДобавитьМоментИГраницуВДерево(дзДерево);
	ПоместитьВоВременноеХранилище(дзДерево, ДеревоТипов);
	
	ОбновитьСоставТипаНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура УбратьМоментИГраницуИзДерева(дзДерево)
	
	Если дзДерево.Строки[4].Имя = "Граница" Тогда
		дзДерево.Строки.Удалить(дзДерево.Строки[4]);
	КонецЕсли;
	
	Если дзДерево.Строки[4].Имя = "МоментВремени" Тогда
		дзДерево.Строки.Удалить(дзДерево.Строки[4]);
	КонецЕсли;
	
	фМоментГраница = Ложь;
	
КонецПроцедуры

&НаСервере
Процедура УбратьМоментИГраницу()
	
	дзДерево = ПолучитьИзВременногоХранилища(ДеревоТипов);
	ОбновитьОтметкиДерева(дзДерево, СоставТипа);
	УбратьМоментИГраницуИзДерева(дзДерево);
	ПоместитьВоВременноеХранилище(дзДерево, ДеревоТипов);
	
	ТекущаяСтрока = Неопределено;
	СоставТипа.ПолучитьЭлементы().Очистить();
	ДеревоТиповВДанныеФормы(дзДерево, СоставТипа, ТекущаяСтрока);
	Элементы.СоставТипа.ТекущаяСтрока = ТекущаяСтрока;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьМоментаИГраницы()
	
	Если ТипКонтейнера = 0 И НЕ СоставнойТип И (НЕ фПростойВид ИЛИ фРедактированиеТипа) Тогда
		Если НЕ фМоментГраница Тогда
			ДобавитьМоментИГраницу();
		КонецЕсли;
	Иначе
		Если фМоментГраница Тогда
			УбратьМоментИГраницу();
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьТип(дзДерево, ТипЗначенияТекущий, стрИмяТипа, Картинки, стрПредставлениеТипа = Неопределено, чИндексВставки = Неопределено)
	
	Если Картинки = Неопределено Тогда
		Картинки = ПолучитьИзВременногоХранилища(Объект.Картинки);
	КонецЕсли;
	
	Если чИндексВставки = Неопределено Тогда
		Строка = дзДерево.Строки.Добавить();
	Иначе
		Строка = дзДерево.Строки.Вставить(чИндексВставки);
	КонецЕсли;
	
	Строка.Имя = стрИмяТипа;
	Если ТипЗнч(Картинки) = Тип("Картинка") Тогда
		Строка.Картинка = Картинки;
	Иначе
		Картинка = Неопределено;
		Если Найти(стрИмяТипа, ".") = 0 Тогда
			Если Картинки.Свойство("Тип_" + стрИмяТипа, Картинка) Тогда
				Строка.Картинка = Картинка;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	Если стрПредставлениеТипа = Неопределено Тогда
		Строка.Представление = стрИмяТипа;
	Иначе
		Строка.Представление = стрПредставлениеТипа;
	КонецЕсли;
	
	Если ТипЗначенияТекущий.СодержитТип(Тип(стрИмяТипа)) Тогда
		Строка.Выбран = Истина;
		Если Строка.Родитель <> Неопределено Тогда
			Строка.Родитель.ВыбранПодч = Истина;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьТипыСсылок(Типы, ТипЗначенияТекущий, Менеджер, стрПрефиксИмени, Картинки)
	Перем КартинкаСсылок;
	
	Картинки.Свойство("Тип_" + стрПрефиксИмени, КартинкаСсылок);
	
	маТипы = Менеджер.ТипВсеСсылки().Типы();
	
	ВеткаТипов = Типы.Строки.Добавить();
	ВеткаТипов.Имя = стрПрефиксИмени;
	ВеткаТипов.Представление = стрПрефиксИмени + " (" + Формат(маТипы.Количество(), "ЧГ=0") + ")";
	ВеткаТипов.ЭтоГруппа = Истина;
	ВеткаТипов.Картинка = КартинкаСсылок;
	
	Для Каждого тТип Из маТипы Цикл
		Ссылка = Новый(тТип);
		стрИмяТипа = Ссылка.Метаданные().Имя;
		стрТип = стрПрефиксИмени + "." + стрИмяТипа;
		ДобавитьТип(ВеткаТипов, ТипЗначенияТекущий, стрТип, КартинкаСсылок, стрИмяТипа);
		//ДобавитьТип(ВеткаТипов, ТипЗначенияТекущий, стрТип, КартинкаСсылок, Строка(тТип));
	КонецЦикла;
	
	ВеткаТипов.Строки.Сортировать("Представление");
	
КонецПроцедуры

&НаСервере
Функция ПолучитьДеревоТипов(ТипЗначенияТекущий, СписокРазрешенных)
	Перем Картинки;
	
	Типы = Новый ДеревоЗначений;
	Типы.Колонки.Добавить("Выбран", Новый ОписаниеТипов("Булево"));
	Типы.Колонки.Добавить("ВыбранПодч", Новый ОписаниеТипов("Булево"));
	Типы.Колонки.Добавить("Имя", Новый ОписаниеТипов("Строка"));
	Типы.Колонки.Добавить("Картинка", Новый ОписаниеТипов("Картинка"));
	Типы.Колонки.Добавить("Представление", Новый ОписаниеТипов("Строка"));
	Типы.Колонки.Добавить("ЭтоГруппа", Новый ОписаниеТипов("Булево"));
	
	ДобавитьТип(Типы, ТипЗначенияТекущий, "Булево", Картинки);
	ДобавитьТип(Типы, ТипЗначенияТекущий, "Дата", Картинки);
	ДобавитьТип(Типы, ТипЗначенияТекущий, "Строка", Картинки);
	ДобавитьТип(Типы, ТипЗначенияТекущий, "Число", Картинки);
	ДобавитьТип(Типы, ТипЗначенияТекущий, "Null", Картинки);
	//ДобавитьТип(Типы, ТипЗначенияТекущий, "Неопределено", Картинки);
	ДобавитьТип(Типы, ТипЗначенияТекущий, "ВидДвиженияНакопления", Картинки, "Вид движения накопления");
	ДобавитьТип(Типы, ТипЗначенияТекущий, "ВидДвиженияБухгалтерии", Картинки, "Вид движения бухгалтерии");
	ДобавитьТип(Типы, ТипЗначенияТекущий, "ВидСчета", Картинки, "Вид счета");
	ДобавитьТип(Типы, ТипЗначенияТекущий, "Тип", Картинки);
	ДобавитьТип(Типы, ТипЗначенияТекущий, "УникальныйИдентификатор", Картинки, "Уникальный идентификатор");

	ДобавитьТипыСсылок(Типы, ТипЗначенияТекущий, Справочники, "СправочникСсылка", Картинки);
	ДобавитьТипыСсылок(Типы, ТипЗначенияТекущий, Документы, "ДокументСсылка", Картинки);
	ДобавитьТипыСсылок(Типы, ТипЗначенияТекущий, Перечисления, "ПеречислениеСсылка", Картинки);
	ДобавитьТипыСсылок(Типы, ТипЗначенияТекущий, ПланыВидовХарактеристик, "ПланВидовХарактеристикСсылка", Картинки);
	ДобавитьТипыСсылок(Типы, ТипЗначенияТекущий, ПланыСчетов, "ПланСчетовСсылка", Картинки);
	ДобавитьТипыСсылок(Типы, ТипЗначенияТекущий, ПланыВидовРасчета, "ПланВидовРасчетаСсылка", Картинки);
	ДобавитьТипыСсылок(Типы, ТипЗначенияТекущий, БизнесПроцессы, "БизнесПроцессСсылка", Картинки);
	ДобавитьТипыСсылок(Типы, ТипЗначенияТекущий, Задачи, "ЗадачаСсылка", Картинки);
	ДобавитьТипыСсылок(Типы, ТипЗначенияТекущий, ПланыОбмена, "ПланОбменаСсылка", Картинки);
	
	Возврат Типы;

КонецФункции

&НаКлиенте
Процедура СоставТипаСброситьВсеКроме(Узел, стрИмяКроме)
	
	СтрокаКроме = Неопределено;
	Для Каждого Строка Из Узел.ПолучитьЭлементы() Цикл
		
		Если Строка.Имя <> стрИмяКроме Тогда
			Строка.Выбран = Ложь;
			Строка.ВыбранПодч = Ложь;
			СоставТипаСброситьВсеКроме(Строка, стрИмяКроме);
		Иначе
			СтрокаКроме = Строка;
		КонецЕсли;
		
	КонецЦикла;
	
	Если СтрокаКроме <> Неопределено И СтрокаКроме.Выбран Тогда
		Родитель = Строка.ПолучитьРодителя();
		Если Родитель <> Неопределено Тогда
			Родитель.ВыбранПодч = Истина;
		КонецЕсли;
	КонецЕсли;
	
	//Мы сбросили все в урезанном дереве на клиенте. В сеансовых данных остались пометки, они уже не действительны.
	//Когда будем на сервере, сбросим их перед обновлением отметок. Для этого этот флаг.
	ФлагСброшеныВсе = Истина;
		
КонецПроцедуры
	
&НаКлиенте
Процедура СоставТипаВыбранПриИзменении(Элемент)
	
	Если НЕ СоставнойТип Тогда
		СоставТипаСброситьВсеКроме(СоставТипа, Элементы.СоставТипа.ТекущиеДанные.Имя);
	КонецЕсли;
	
	Если Элементы.СоставТипа.ТекущиеДанные.Выбран Тогда
		Родитель = Элементы.СоставТипа.ТекущиеДанные.ПолучитьРодителя();
		Если Родитель <> Неопределено Тогда
			Родитель.ВыбранПодч = Истина;
		КонецЕсли;
	КонецЕсли;
	
	ОбновитьОтображениеКвалификаторов();

КонецПроцедуры

&НаСервере
Функция СоставнойТипПриИзмененииНаСервере()
	
	стрТекущееИмя = Неопределено;
	
	Если СоставнойТип Тогда
		УстановитьВидимостьЭлементов();
	Иначе
		стрТекущееИмя = ПолучитьПервыйВыбранный(СоставТипа);
		УстановитьВидимостьЭлементов();
	КонецЕсли;
	
	Возврат стрТекущееИмя;
	
КонецФункции

&НаКлиенте
Процедура СоставнойТипПриИзменении(Элемент)
	
	стрТекущееИмя = СоставнойТипПриИзмененииНаСервере();
	
	Если НЕ СоставнойТип Тогда
		СоставТипаСброситьВсеКроме(СоставТипа, стрТекущееИмя);
	КонецЕсли;
	
	УстановитьСостояниеДереваТипов();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьОтображениеКвалификаторов() Экспорт
	
	Если НЕ фРедактированиеТипа Тогда
		
		фВидимостьКвалификаторовЧисла = Элементы.СоставТипа.ТекущиеДанные <> Неопределено И Элементы.СоставТипа.ТекущиеДанные.Выбран И Элементы.СоставТипа.ТекущиеДанные.Имя = "Число";
		фВидимостьКвалификаторовСтроки = Элементы.СоставТипа.ТекущиеДанные <> Неопределено И Элементы.СоставТипа.ТекущиеДанные.Выбран И Элементы.СоставТипа.ТекущиеДанные.Имя = "Строка";
		фВидимостьКвалификаторовДаты = Элементы.СоставТипа.ТекущиеДанные <> Неопределено И Элементы.СоставТипа.ТекущиеДанные.Выбран И Элементы.СоставТипа.ТекущиеДанные.Имя = "Дата";
		
		Элементы.ГруппаКвалификаторыЧисла.Видимость = фВидимостьКвалификаторовЧисла;
		Элементы.ГруппаКвалификаторыСтроки.Видимость = фВидимостьКвалификаторовСтроки;
		Элементы.ГруппаКвалификаторыДаты.Видимость = фВидимостьКвалификаторовДаты;
		
		Если фВидимостьКвалификаторовСтроки Тогда
			Если КвалификаторыСтрокиДлина = 0 Тогда
				КвалификаторыСтрокиКомментарий = "(неограниченная)";
				Элементы.КвалификаторыСтрокиФиксированная.Видимость = Ложь;
			Иначе
				КвалификаторыСтрокиКомментарий = "";
				Элементы.КвалификаторыСтрокиФиксированная.Видимость = Истина;
			КонецЕсли;
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СоставТипаПриАктивизацииСтроки(Элемент)
	ПодключитьОбработчикОжидания("ОбновитьОтображениеКвалификаторов", 0.1, Истина);
КонецПроцедуры

&НаКлиенте
Процедура КвалификаторыСтрокиДлинаПриИзменении(Элемент)
	ОбновитьОтображениеКвалификаторов();
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьЭлементов()
	
	фТаблица = ТипКонтейнера = 3;
	Элементы.ГруппаТипЗначения.Видимость = НЕ фТаблица;
	Элементы.ГруппаРедактированиеТаблицы.Видимость = фТаблица;
	Элементы.КомандаВЗапрос.Видимость = фТаблица И ВЗапросРазрешено;
	
	Если НЕ фТаблица Тогда
		УстановитьВидимостьМоментаИГраницы();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура КонтейнерПриИзменении(Элемент)
	УстановитьВидимостьЭлементов();
	УстановитьСостояниеДереваТипов();
КонецПроцедуры

&НаКлиенте
Процедура ОкончаниеРедактированияТипа(РезультатЗакрытия, ДополнительныеПараметры) Экспорт
	
	Если РезультатЗакрытия <> Неопределено Тогда
		
		СтрокаСтруктуры = ДополнительныеПараметры.Таблица.НайтиПоИдентификатору(ДополнительныеПараметры.Строка);
		СтрокаСтруктуры.ТипЗначения = РезультатЗакрытия.ОписаниеКонтейнера;
		СтрокаСтруктуры.Квалификаторы = ПолучитьПредставлениеКвалификаторовТипа(РезультатЗакрытия.ОписаниеКонтейнера);
		
	КонецЕсли;
		
КонецПроцедуры

&НаКлиенте
Процедура СтруктураТаблицыТипЗначенияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ТипЗначения = Элементы.СтруктураТаблицы.ТекущиеДанные.ТипЗначения;
	
	ПараметрыОповещения = Новый Структура("Таблица, Строка, Поле", СтруктураТаблицы, Элементы.СтруктураТаблицы.ТекущаяСтрока, "ТипЗначения");
	ОписаниеОповещенияОЗакрытииОткрываемойФормы = Новый ОписаниеОповещения("ОкончаниеРедактированияТипа", ЭтаФорма, ПараметрыОповещения);
	ПараметрыОткрытия = Новый Структура("Объект, ТипЗначения", Объект, ТипЗначения);
	ОткрытьФорму(ПолноеИмяФормы("РедактированиеТипа"), ПараметрыОткрытия, ЭтаФорма, Истина, , , ОписаниеОповещенияОЗакрытииОткрываемойФормы, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
	СтандартнаяОбработка = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура СоставТипаПриИзменении(Элемент)
	
	Если Элементы.СоставТипа.ТекущиеДанные.ЭтоГруппа Тогда
		
		Если СоставнойТип Тогда
			
			ЭлементыГруппы = СоставТипа.НайтиПоИдентификатору(Элементы.СоставТипа.ТекущаяСтрока).ПолучитьЭлементы();
			фВыбранРодитель = Элементы.СоставТипа.ТекущиеДанные.Выбран;
			Для Каждого Элемент Из ЭлементыГруппы Цикл
				Элемент.Выбран = фВыбранРодитель;
			КонецЦикла;
			
			Элементы.СоставТипа.ТекущиеДанные.ВыбранПодч = фВыбранРодитель;
			
		Иначе
			Элементы.СоставТипа.ТекущиеДанные.Выбран = Ложь;
			Элементы.СоставТипа.Развернуть(Элементы.СоставТипа.ТекущаяСтрока);
		КонецЕсли;
		
	Иначе
		
		Родитель = СоставТипа.НайтиПоИдентификатору(Элементы.СоставТипа.ТекущаяСтрока).ПолучитьРодителя();
		Если Родитель <> Неопределено Тогда
			
			Если Элементы.СоставТипа.ТекущиеДанные.Выбран Тогда
				Родитель.ВыбранПодч = Истина;
			Иначе
				Родитель.ВыбранПодч = Ложь;
				ЭлементыГруппы = Родитель.ПолучитьЭлементы();
				Для Каждого Элемент Из ЭлементыГруппы Цикл
					Если Элемент.Выбран Тогда
						Родитель.ВыбранПодч = Истина;
						Прервать;
					КонецЕсли;
				КонецЦикла;
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СтрокаПоискаИзменениеТекстаРедактирования(Элемент, Текст, СтандартнаяОбработка)
	СтрокаПоиска = Текст;
	СтандартнаяОбработка = Ложь;
	ОбновитьСоставТипа();
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьИзменениеИмениКолонки(НоваяСтрока, ОтменаРедактирования, Отказ)
	
	стрИмяКолонки = Элементы.СтруктураТаблицы.ТекущиеДанные.Имя;
	
	фИмяКорректно = Ложь;
	Попытка
		ст = Новый Структура(стрИмяКолонки);
		фИмяКорректно = ЗначениеЗаполнено(стрИмяКолонки);
	Исключение
	КонецПопытки;
	
	Если НЕ фИмяКорректно Тогда
		ПоказатьПредупреждение(, "Неверное имя колонки! Имя должно состоять из одного слова, начинаться с буквы и не содержать специальных символов кроме ""_"".", , Заголовок);
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	маСтрокиИмени = СтруктураТаблицы.НайтиСтроки(Новый Структура("Имя", стрИмяКолонки));
	Если маСтрокиИмени.Количество() > 1 Тогда
		ПоказатьПредупреждение(, "Колонка с таким именем уже есть! Введите другое имя.", , Заголовок);
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СтруктураТаблицыПередОкончаниемРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования, Отказ)
	ОбработатьИзменениеИмениКолонки(НоваяСтрока, ОтменаРедактирования, Отказ);
КонецПроцедуры

