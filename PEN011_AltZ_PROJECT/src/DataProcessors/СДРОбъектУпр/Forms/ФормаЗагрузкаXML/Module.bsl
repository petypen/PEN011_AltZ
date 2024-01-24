
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Параметры.Свойство("_ПутьКФормам", _ПутьКФормам);
	
	_ЗагружатьВРежимеОбменДанными = истина;
КонецПроцедуры

&НаКлиенте
Функция вРазобратьПутьКФайлу(ПутьКФайлу)
	пСтрук = новый Структура("Каталог, Имя", "", "");
	
	Если не ПустаяСтрока(ПутьКФайлу) Тогда
		Поз = СтрНайти(ПутьКФайлу, "\", НаправлениеПоиска.СКонца);
		Если Поз <> 0 Тогда
			пСтрук.Каталог = СокрЛП(Лев(ПутьКФайлу, Поз-1));
			пСтрук.Имя = СокрЛП(Сред(ПутьКФайлу, Поз+1));
		Иначе
			пСтрук.Имя = СокрЛП(ПутьКФайлу);
		КонецЕсли;
	КонецЕсли;
	
	Возврат пСтрук;
КонецФункции

&НаКлиенте
Процедура _ПутьКФайлуXMLПриИзменении(Элемент)
	_ПутьКФайлуXML = СокрЛП(_ПутьКФайлуXML);
КонецПроцедуры

&НаКлиенте
Процедура _ПутьКФайлуXMLОткрытие(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = ложь;
	
	Если не ПустаяСтрока(_ПутьКФайлуXML) Тогда
		ТДок = новый ТекстовыйДокумент;
		ТДок.НачатьЧтение(новый ОписаниеОповещения("вПослеЧтенияФайлаXML", ЭтаФорма, ТДок), _ПутьКФайлуXML, "UTF-8");
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура вПослеЧтенияФайлаXML(ТДок = Неопределено) Экспорт
	Если ТипЗнч(ТДок) = Тип("ТекстовыйДокумент") Тогда
		ТДок.Показать(_ПутьКФайлуXML);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура _ПутьКФайлуXMLНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = ложь;
	
	пСтрук = вРазобратьПутьКФайлу(_ПутьКФайлуXML);
	
	пДиалогВыбораФайла = новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	пДиалогВыбораФайла.ПроверятьСуществованиеФайла = истина;
	пДиалогВыбораФайла.Каталог = пСтрук.Каталог;
	пДиалогВыбораФайла.ПолноеИмяФайла = пСтрук.Имя;
	пДиалогВыбораФайла.Заголовок  = "Файл данных XML";
	пДиалогВыбораФайла.Фильтр     = "Файлы данных XML (*.xml)|*.xml|Все файлы (*.*)|*.*";
	пДиалогВыбораФайла.Расширение = "xml";
	
	пДиалогВыбораФайла.Показать(новый ОписаниеОповещения("вОбработатьВыборФайла", ЭтаФорма));
КонецПроцедуры

&НаКлиенте
Процедура вОбработатьВыборФайла(ВыбранныеФайлы, ДопПарам = Неопределено) Экспорт
	Если ТипЗнч(ВыбранныеФайлы) = Тип("Массив") Тогда
		_ПутьКФайлуXML = ВыбранныеФайлы[0];
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура _ДополнительныеСвойстваЗначениеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ТекДанные = Элементы._ДополнительныеСвойства.ТекущиеДанные;
	
	Если ТекДанные <> Неопределено Тогда
		Если ТекДанные.Значение = Неопределено Тогда
			СтандартнаяОбработка = ложь;
			СтрукПарам = новый Структура("ЗакрыватьПриЗакрытииВладельца, ПоказыватьПростыеТипы", истина, истина);
			ОткрытьФорму(_ПутьКФормам + "ФормаВыбораОбъекта", СтрукПарам, Элемент,,,,,РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		Иначе
			Массив = новый Массив;
			Массив.Добавить(ТипЗнч(ТекДанные.Значение));
			Элемент.ОграничениеТипа = новый ОписаниеТипов(Массив);
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура _ДополнительныеСвойстваЗначениеОчистка(Элемент, СтандартнаяОбработка)
	Элемент.ОграничениеТипа = новый ОписаниеТипов();
КонецПроцедуры

&НаКлиенте
Процедура _ЗагрузитьДанные(Команда)
	Если _ЗагружатьДанныеБезИспользованияФайла Тогда
		Если ПустаяСтрока(_ДанныеXML) Тогда
			ПоказатьПредупреждение(, "Нет данных для загрузки!", 10);
			Возврат;
		КонецЕсли;
	ИначеЕсли ПустаяСтрока(_ПутьКФайлуXML) Тогда
		ПоказатьПредупреждение(, "Не задан файл для загрузки данных!", 10);
		Возврат;
	КонецЕсли;
	
	пСтрук = новый Структура;
	пСтрук.Вставить("Режим", "Загрузка");
	пСтрук.Вставить("ДанныеXML", ?(_ЗагружатьДанныеБезИспользованияФайла, _ДанныеXML, ""));
	пСтрук.Вставить("ПутьКФайлуXML", _ПутьКФайлуXML);
	пСтрук.Вставить("ЗагружатьДанныеБезИспользованияФайла", _ЗагружатьДанныеБезИспользованияФайла);
	пСтрук.Вставить("ЗагружатьВРежимеОбменДанными", _ЗагружатьВРежимеОбменДанными);
	пСтрук.Вставить("ЗагружатьВТранзакции", _ЗагружатьВТранзакции);
	пСтрук.Вставить("ПродолжатьЗагрузкуПриОшибке", _ПродолжатьЗагрузкуПриОшибке);
	пСтрук.Вставить("ИспользоватьДополнительныеСвойстваПриЗаписи", _ИспользоватьДополнительныеСвойстваПриЗаписи);
	пСтрук.Вставить("ИспользоватьПроцедуруПередЗаписью", _ИспользоватьПроцедуруПередЗаписью);
	пСтрук.Вставить("ПроцедураПередЗаписью", _ПроцедураПередЗаписью);
	пСтрук.Вставить("ДополнительныеСвойства", новый Структура);
	
	Если _ИспользоватьДополнительныеСвойстваПриЗаписи Тогда
		пДопСвойства = новый Структура;
		
		Для каждого Элем из _ДополнительныеСвойства Цикл
			Попытка
				пДопСвойства.Вставить(Элем.Ключ, Элем.Значение);
			Исключение
				Сообщить("Неправильное значение ключа дополнительного свойства: " + ?(ПустаяСтрока(Элем.Ключ), "<пусто>", Элем.Ключ));
				Возврат;
			КонецПопытки;
		КонецЦикла;
		
		пСтрук.Вставить("ДополнительныеСвойства", пДопСвойства);
	КонецЕсли;
	
	Закрыть(пСтрук);
КонецПроцедуры
