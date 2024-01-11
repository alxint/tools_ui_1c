#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Свойство("РежимЗапуска") Тогда
		//@skip-check unknown-form-parameter-access
		РежимРаботы = Параметры.РежимЗапуска;
	Иначе
		РежимРаботы = -1;
	КонецЕсли;
	
	ДоступныеНаборыТипов = УИ_ОбщегоНазначенияКлиентСервер.ДоступныеНаборыТиповДляРедактирования();
	
	//Набор типов можт содержать значения
	// Ссылки
	// СоставныеСсылки
	// Примитивные
	// Null
	// ХранилищеЗначений
	// КоллекцииЗначений 
	// МоментВремени
	// Тип
	// Граница
	// УникальныйИдентификатор
	// СтандартныйПериод
	// СистемныеПеречисления
	
	НаборТипов.Очистить();
	
	Если РежимРаботы = 0 Тогда
		НаборТипов.Добавить(ДоступныеНаборыТипов.Ссылки);
		НаборТипов.Добавить(ДоступныеНаборыТипов.СоставныеСсылки);
		НаборТипов.Добавить(ДоступныеНаборыТипов.Примитивные);
		НаборТипов.Добавить(ДоступныеНаборыТипов.ХранилищеЗначения);
		НаборТипов.Добавить(ДоступныеНаборыТипов.УникальныйИдентификатор);
	ИначеЕсли РежимРаботы = 1 Тогда 
		НаборТипов.Добавить(ДоступныеНаборыТипов.Ссылки);
		НаборТипов.Добавить(ДоступныеНаборыТипов.СоставныеСсылки);
		НаборТипов.Добавить(ДоступныеНаборыТипов.Примитивные);
		НаборТипов.Добавить(ДоступныеНаборыТипов.ХранилищеЗначения);
		НаборТипов.Добавить(ДоступныеНаборыТипов.УникальныйИдентификатор);
		НаборТипов.Добавить(ДоступныеНаборыТипов.КоллекцииЗначений);
		НаборТипов.Добавить(ДоступныеНаборыТипов.МоментВремени);
		НаборТипов.Добавить(ДоступныеНаборыТипов.Тип);
		НаборТипов.Добавить(ДоступныеНаборыТипов.Граница);
		НаборТипов.Добавить(ДоступныеНаборыТипов.УникальныйИдентификатор);
		НаборТипов.Добавить(ДоступныеНаборыТипов.Null);
	ИначеЕсли РежимРаботы = 2 Тогда 
		НаборТипов.Добавить(ДоступныеНаборыТипов.Ссылки);
		НаборТипов.Добавить(ДоступныеНаборыТипов.СоставныеСсылки);
		НаборТипов.Добавить(ДоступныеНаборыТипов.Примитивные);
		НаборТипов.Добавить(ДоступныеНаборыТипов.ХранилищеЗначения);
		НаборТипов.Добавить(ДоступныеНаборыТипов.УникальныйИдентификатор);
		НаборТипов.Добавить(ДоступныеНаборыТипов.Null);
	ИначеЕсли РежимРаботы = 3 Тогда 
		НаборТипов.Добавить(ДоступныеНаборыТипов.Ссылки);
		НаборТипов.Добавить(ДоступныеНаборыТипов.СоставныеСсылки);
		НаборТипов.Добавить(ДоступныеНаборыТипов.Примитивные);
		НаборТипов.Добавить(ДоступныеНаборыТипов.ХранилищеЗначения);
		НаборТипов.Добавить(ДоступныеНаборыТипов.УникальныйИдентификатор);
		НаборТипов.Добавить(ДоступныеНаборыТипов.Null);
		НаборТипов.Добавить(ДоступныеНаборыТипов.СтандартныйПериод);
		НаборТипов.Добавить(ДоступныеНаборыТипов.СистемныеПеречисления);
	ИначеЕсли Параметры.Свойство("НаборТипов") Тогда
		//@skip-check unknown-form-parameter-access
		ВременныеНаборТипов = Параметры.НаборТипов;
		Если ТипЗнч(ВременныеНаборТипов) = Тип("Строка") Тогда
			ВременныйМассивТипов = СтрРазделить(ВременныеНаборТипов, ",");
			Для Каждого ТекНабор Из ВременныйМассивТипов Цикл
				НаборТипов.Добавить(ВРег(ТекНабор));
			КонецЦикла;
		ИначеЕсли ТипЗнч(ВременныеНаборТипов) = Тип("СписокЗначений") Тогда
			Для Каждого ТекНабор Из ВременныеНаборТипов Цикл
				НаборТипов.Добавить(ВРег(ТекНабор.Значение));
			КонецЦикла;

		ИначеЕсли ТипЗнч(ВременныеНаборТипов) = Тип("Массив") Тогда
			Для Каждого ТекНабор Из ВременныеНаборТипов Цикл
				НаборТипов.Добавить(ВРег(ТекНабор));
			КонецЦикла;
		КонецЕсли;
	КонецЕсли;
		
	НачальныйТипДанных = Новый ОписаниеТипов;
	Если Параметры.Свойство("ТипДанных") Тогда
		//@skip-check unknown-form-parameter-access
		ТипДанных=Параметры.ТипДанных;
		Если ТипЗнч(ТипДанных) = Тип("ОписаниеТипов") Тогда
			НачальныйТипДанных=ТипДанных;
		КонецЕсли;
	ИначеЕсли Параметры.Свойство("ХранилищеКонтейнераЗначенияТипа") Тогда 
		ВозвратХранилищаДляКонтейнераЗначения = Истина;
		ТипКонтейнераЗначения = УИ_ОбщегоНазначенияКлиентСервер.ТипыКонтейнеровЗначения().Тип;
		//@skip-check unknown-form-parameter-access
		ХранилищеКонтейнера = Параметры.ХранилищеКонтейнераЗначенияТипа;//см. УИ_ОбщегоНазначенияКлиентСервер.НовыйХранилищеЗначенияТипа
		Если ХранилищеКонтейнера <> Неопределено Тогда
			Попытка
				ТипДанныхКонтейнера = ЗначениеИзСтрокиВнутр(ХранилищеКонтейнера.Значение);
				МассивТиповДляОписания = Новый Массив();
				МассивТиповДляОписания.Добавить(ТипДанныхКонтейнера);
				НачальныйТипДанных = Новый ОписаниеТипов(МассивТиповДляОписания);
			Исключение
				УИ_ОбщегоНазначенияКлиентСервер.СообщитьПользователю("Не удалось прочитать тип из контейнера.");
			КонецПопытки;
		КонецЕсли;
	КонецЕсли;
	
	СоставнойТип = НачальныйТипДанных.Типы().Количество() > 1;

	Если Параметры.Свойство("ДоступенСоставнойТип") Тогда
		//@skip-check unknown-form-parameter-access
		ДоступенСоставнойТип = Параметры.ДоступенСоставнойТип;
	Иначе
		ДоступенСоставнойТип = Истина;
	КонецЕсли;
	
	Если Параметры.Свойство("РежимВыбора") Тогда
		//@skip-check unknown-form-parameter-access
		РежимВыбора = Параметры.РежимВыбора;
		Если РежимВыбора Тогда
			ДоступенСоставнойТип = Ложь;
		КонецЕсли;
	Иначе
		РежимВыбора = Ложь;
	КонецЕсли;
	
	Если РежимВыбора Тогда
		Заголовок = "Выбор типа";
	КонецЕсли;
	
	Если Не ДоступенСоставнойТип Тогда
		СоставнойТип = Ложь;
		Элементы.СоставнойТип.Видимость = Ложь;
	КонецЕсли;
	
//	Элементы.ДеревоТиповВыбран.Видимость = Не РежимВыбора;
	Элементы.ГруппаВыбораФормыВыбораСсылочногоЗначения.Видимость = РежимВыбора
																   И Не ВозвратХранилищаДляКонтейнераЗначения;

	ЗаполнитьДанныеКвалификаторовПоПервоначальномуТипуДанных(НачальныйТипДанных);
	
	ЗаполнитьДеревоТипов(Истина);
	
	УстановитьУсловноеОформление();
КонецПроцедуры


#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура НеограниченнаяДлинаСтрокиПриИзменении(Элемент)
	Если НеограниченнаяДлинаСтроки Тогда
		ДлинаСтроки=0;
		ДопустамаяДлинаСтрокиФиксированная=Ложь;
	КонецЕсли;
	Элементы.ДопустамаяДлинаСтрокиФиксированная.Доступность=Не НеограниченнаяДлинаСтроки;
КонецПроцедуры

&НаКлиенте
Процедура ДлинаСтрокиПриИзменении(Элемент)
	Если Не ЗначениеЗаполнено(ДлинаСтроки) Тогда
		НеограниченнаяДлинаСтроки=Истина;
		ДопустамаяДлинаСтрокиФиксированная=Ложь;
	Иначе
		НеограниченнаяДлинаСтроки=Ложь;
	КонецЕсли;
	Элементы.ДопустамаяДлинаСтрокиФиксированная.Доступность=Не НеограниченнаяДлинаСтроки;
КонецПроцедуры

&НаКлиенте
Процедура СтрокаПоискаПриИзменении(Элемент)
	ЗаполнитьДеревоТипов();
	РазвернутьЭлементыДерева();
КонецПроцедуры

&НаКлиенте
Процедура СоставнойТипПриИзменении(Элемент)
	Если Не СоставнойТип Тогда
		Если ВыбранныеТипы.Количество()=0 Тогда
			ДобавитьВыбранныйТип("Строка");
		КонецЕсли;
		Тип=ВыбранныеТипы[ВыбранныеТипы.Количество()-1];
		ВыбранныеТипы.Очистить();
		ДобавитьВыбранныйТип(Тип);
		
		УстановитьВыбранныеТипыВДереве(ДеревоТипов,ВыбранныеТипы);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыДеревоТипов

&НаКлиенте
Процедура ДеревоТиповВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	ТекСтрока = ДеревоТипов.НайтиПоИдентификатору(ВыбраннаяСтрока);
	Если ТекСтрока = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ТекСтрока.Выбран = Истина;
	ОбработчикИзмененияПризнакаВыбораТипа(ТекСтрока);
	
	Если РежимВыбора И Не СоставнойТип Тогда
		ЗавершитьРедактированиеТипаИЗакрытьФорму();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ДеревоТиповВыбранПриИзменении(Элемент)
	ТекСтрока=Элементы.ДеревоТипов.ТекущиеДанные;
	Если ТекСтрока=Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ОбработчикИзмененияПризнакаВыбораТипа(ТекСтрока);	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоТиповПриАктивизацииСтроки(Элемент)
	ТекДанные=Элементы.ДеревоТипов.ТекущиеДанные;
	Если ТекДанные=Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Элементы.ГруппаКвалификаторЧисла.Видимость=ТекДанные.Имя="Число";
	Элементы.ГруппаКвалификаторСтроки.Видимость=ТекДанные.Имя="Строка";
	Элементы.ГруппаКвалификаторДаты.Видимость=ТекДанные.Имя="Дата";
	
КонецПроцедуры



#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Применить(Команда)
	ЗавершитьРедактированиеТипаИЗакрытьФорму();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции


&НаСервере
Процедура ДобавитьТипыВМассивПоКоллекцииМетаданных(МассивТипов, Коллекция, ПрефиксТипа)
	Для Каждого ОбъектМД ИЗ Коллекция Цикл
		МассивТипов.Добавить(Тип(ПрефиксТипа+ОбъектМД.Имя));
	КонецЦикла;
КонецПроцедуры

&НаСервере
Функция МассивВыбранныхТипов()
	МассивТипов=Новый Массив;
	
	Для Каждого ЭлементТипа Из ВыбранныеТипы Цикл
		СтрокаТипа=ЭлементТипа.Значение;
		
		Если НРег(СтрокаТипа)="любаяссылка" Тогда
			ДобавитьТипыВМассивПоКоллекцииМетаданных(МассивТипов, Метаданные.Справочники,"СправочникСсылка.");
			ДобавитьТипыВМассивПоКоллекцииМетаданных(МассивТипов, Метаданные.Документы,"ДокументСсылка.");
			ДобавитьТипыВМассивПоКоллекцииМетаданных(МассивТипов, Метаданные.ПланыВидовХарактеристик,"ПланВидовХарактеристикСсылка.");
			ДобавитьТипыВМассивПоКоллекцииМетаданных(МассивТипов, Метаданные.ПланыСчетов,"ПланСчетовСсылка.");
			ДобавитьТипыВМассивПоКоллекцииМетаданных(МассивТипов, Метаданные.ПланыВидовРасчета,"ПланВидовРасчетаСсылка.");
			ДобавитьТипыВМассивПоКоллекцииМетаданных(МассивТипов, Метаданные.ПланыОбмена,"ПланОбменаСсылка.");
			ДобавитьТипыВМассивПоКоллекцииМетаданных(МассивТипов, Метаданные.Перечисления,"ПеречислениеСсылка.");
			ДобавитьТипыВМассивПоКоллекцииМетаданных(МассивТипов, Метаданные.БизнесПроцессы,"БизнесПроцессСсылка.");
			ДобавитьТипыВМассивПоКоллекцииМетаданных(МассивТипов, Метаданные.Задачи,"ЗадачаСсылка.");
		ИначеЕсли СтрНайти(НРег(СтрокаТипа),"ссылка")>0 И СтрНайти(СтрокаТипа,".")=0 Тогда
			Если НРег(СтрокаТипа)="справочникссылка" Тогда
				ДобавитьТипыВМассивПоКоллекцииМетаданных(МассивТипов, Метаданные.Справочники,"СправочникСсылка.");
			ИначеЕсли НРег(СтрокаТипа)="документссылка" Тогда	
				ДобавитьТипыВМассивПоКоллекцииМетаданных(МассивТипов, Метаданные.Документы,"ДокументСсылка.");
			ИначеЕсли НРег(СтрокаТипа)="планвидовхарактеристикссылка" Тогда	
				ДобавитьТипыВМассивПоКоллекцииМетаданных(МассивТипов, Метаданные.ПланыВидовХарактеристик,"ПланВидовХарактеристикСсылка.");
			ИначеЕсли НРег(СтрокаТипа)="плансчетовссылка" Тогда	
				ДобавитьТипыВМассивПоКоллекцииМетаданных(МассивТипов, Метаданные.ПланыСчетов,"ПланСчетовСсылка.");
			ИначеЕсли НРег(СтрокаТипа)="планвидоврасчетассылка" Тогда	
				ДобавитьТипыВМассивПоКоллекцииМетаданных(МассивТипов, Метаданные.ПланыВидовРасчета,"ПланВидовРасчетаСсылка.");
			ИначеЕсли НРег(СтрокаТипа)="планобменассылка" Тогда	
				ДобавитьТипыВМассивПоКоллекцииМетаданных(МассивТипов, Метаданные.ПланыОбмена,"ПланОбменаСсылка.");
			ИначеЕсли НРег(СтрокаТипа)="перечислениессылка" Тогда	
				ДобавитьТипыВМассивПоКоллекцииМетаданных(МассивТипов, Метаданные.Перечисления,"ПеречислениеСсылка.");
			ИначеЕсли НРег(СтрокаТипа)="бизнеспроцессссылка" Тогда	
				ДобавитьТипыВМассивПоКоллекцииМетаданных(МассивТипов, Метаданные.БизнесПроцессы,"БизнесПроцессСсылка.");
			ИначеЕсли НРег(СтрокаТипа)="задачассылка" Тогда	
				ДобавитьТипыВМассивПоКоллекцииМетаданных(МассивТипов, Метаданные.Задачи,"ЗадачаСсылка.");
			КонецЕсли;
		ИначеЕсли ЭлементТипа.Пометка Тогда
			МассивИмени=СтрРазделить(СтрокаТипа,".");
			Если МассивИмени.Количество()<>2 Тогда
				Продолжить;
			КонецЕсли;
			ИмяОбъекта=МассивИмени[1];
			Если СтрНайти(НРег(СтрокаТипа),"характеристика")>0 Тогда
				ОбъектМД=Метаданные.ПланыВидовХарактеристик[ИмяОбъекта];
			ИначеЕсли СтрНайти(НРег(СтрокаТипа),"определяемыйтип")>0 Тогда
				ОбъектМД=Метаданные.ОпределяемыеТипы[ИмяОбъекта];
			Иначе
				Продолжить;
			КонецЕсли;
			ОписаниеТипа=ОбъектМД.Тип;
			
			Для Каждого ТекТип ИЗ ОписаниеТипа.Типы() Цикл
				МассивТипов.Добавить(ТекТип);
			КонецЦикла;
			
		Иначе
			МассивТипов.Добавить(ЭлементТипа.Значение);
		КонецЕсли;
	КонецЦикла;
	
	Возврат МассивТипов;
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ВыбранноеОписаниеТипов(Форма, МассивТипов)
	ТипыСтрокой=Новый Массив;
	ТипыТипом=Новый Массив;

	Для Каждого Тип Из МассивТипов Цикл
		Если ТипЗнч(Тип) = Тип("Тип") Тогда
			ТипыТипом.Добавить(Тип);
		Иначе
			ТипыСтрокой.Добавить(Тип);
		КонецЕсли;
	КонецЦикла;

	Если Форма.НеотрицательноеЧисло Тогда
		Знак=ДопустимыйЗнак.Неотрицательный;
	Иначе
		Знак=ДопустимыйЗнак.Любой;
	КонецЕсли;

	КвалификаторЧисла=Новый КвалификаторыЧисла(Форма.ДлинаЧисла, Форма.ТочностьЧисла, Знак);
	КвалификаторСтроки=Новый КвалификаторыСтроки(Форма.ДлинаСтроки, ?(Форма.ДопустамаяДлинаСтрокиФиксированная,
																	  ДопустимаяДлина.Фиксированная,
																	  ДопустимаяДлина.Переменная));
	
	Если Форма.СоставДаты = 1 Тогда
		ЧастьДаты=ЧастиДаты.Время;
	ИначеЕсли Форма.СоставДаты = 2 Тогда
		ЧастьДаты=ЧастиДаты.ДатаВремя;
	Иначе
		ЧастьДаты=ЧастиДаты.Дата;
	КонецЕсли;
	
	КвалификаторДаты=Новый КвалификаторыДаты(ЧастьДаты);

	Описание=Новый ОписаниеТипов;
	Если ТипыТипом.Количество() > 0 Тогда
		Описание=Новый ОписаниеТипов(Описание, ТипыТипом, , КвалификаторЧисла, КвалификаторСтроки, КвалификаторДаты);
	КонецЕсли;
	Если ТипыСтрокой.Количество() > 0 Тогда
		Описание=Новый ОписаниеТипов(Описание, СтрСоединить(ТипыСтрокой, ","), , КвалификаторЧисла, КвалификаторСтроки,
			КвалификаторДаты);
	КонецЕсли;
	
	Возврат Описание;
КонецФункции

&НаСервере
Функция ВозвращаемоеХранилищеДляКонтейнера()
	МассивТипов=МассивВыбранныхТипов();
	
	Описание = ВыбранноеОписаниеТипов(ЭтотОбъект, МассивТипов);
	
	ХранилищеТипа = УИ_ОбщегоНазначенияКлиентСервер.НовыйХранилищеЗначенияТипа();
	ХранилищеТипа.Имя = Строка(Описание);
	
	ТипыКонтейнеров = УИ_ОбщегоНазначенияКлиентСервер.ТипыКонтейнеровЗначения();
	Если ТипКонтейнераЗначения = ТипыКонтейнеров.Тип Тогда
		Типы = Описание.Типы();
		Если Типы.Количество() =0  Тогда
			ТипВКонтейнер = Тип("Неопределено");
		Иначе
			ТипВКонтейнер = Типы[0];
		КонецЕсли;
		
		ХранилищеТипа.Значение = ЗначениеВСтрокуВнутр(ТипВКонтейнер);
	Иначе
		ХранилищеТипа.Значение = УИ_ОбщегоНазначения.ЗначениеВСтрокуXML(Описание);
	КонецЕсли;
	
	Возврат ХранилищеТипа;
КонецФункции

&НаКлиенте
Процедура ОбработчикИзмененияПризнакаВыбораТипа(ТекСтрока)
	
	Если ТекСтрока.Выбран Тогда
		Если Не СоставнойТип Тогда
			ВыбранныеТипы.Очистить();
		ИначеЕсли ТекСтрока.НедоступенДляСоставногоТипа Тогда
			Если ВыбранныеТипы.Количество() > 0 Тогда
				ПоказатьВопрос(Новый ОписаниеОповещения("ДеревоТиповВыбранПриИзмененииЗавершение", ЭтотОбъект,
					Новый Структура("ТекСтрока", ТекСтрока)), "Выбран тип, который не может быть включен в составной тип данных.
															  |Будут исключены остальные типы данных.
															  |Продолжить?", РежимДиалогаВопрос.ДаНет);
				Возврат;
			КонецЕсли;
		Иначе
			ЕстьНедоступныйДляСоставногоТипа=Ложь;
			Для Каждого Эл Из ВыбранныеТипы Цикл
				Если Эл.Пометка Тогда
					ЕстьНедоступныйДляСоставногоТипа=Истина;
					Прервать;
				КонецЕсли;
			КонецЦикла;
			
			Если ЕстьНедоступныйДляСоставногоТипа Тогда
				ПоказатьВопрос(Новый ОписаниеОповещения("ДеревоТиповВыбранПриИзмененииЗавершениеБылЗапрещенныйДляСоставногоТип",
					ЭтотОбъект, Новый Структура("ТекСтрока", ТекСтрока)), "Ранее был выбран тип, который не может быть 
																		  |включен в составной тип данных и будет исключен.
																		  |Продолжить?", РежимДиалогаВопрос.ДаНет);
				Возврат;
			КонецЕсли;
		КонецЕсли;
	Иначе
		Элемент=ВыбранныеТипы.НайтиПоЗначению(ТекСтрока.Имя);
		Если Элемент <> Неопределено Тогда
			ВыбранныеТипы.Удалить(Элемент);
		КонецЕсли;

	КонецЕсли;
	ДеревоТиповВыбранПриИзмененииФрагмент(ТекСтрока);

	
КонецПроцедуры

&НаКлиенте
Процедура ЗавершитьРедактированиеТипаИЗакрытьФорму()
	Если ВозвратХранилищаДляКонтейнераЗначения Тогда
		ВозвращаемоеЗначение = ВозвращаемоеХранилищеДляКонтейнера();
	Иначе
		МассивТипов=МассивВыбранныхТипов();
		
		Описание = ВыбранноеОписаниеТипов(ЭтотОбъект, МассивТипов);
		ВозвращаемоеЗначение = Описание;
		Если РежимВыбора Тогда
			ВозвращаемоеЗначение = Новый Структура;
			ВозвращаемоеЗначение.Вставить("Описание", Описание);
			ВозвращаемоеЗначение.Вставить("ИспользоватьДинамическийСписокДляВыбораСсылочногоЗначения",
										  ИспользоватьДинамическийСписокДляВыбораСсылочногоЗначения);
		КонецЕсли;
	КонецЕсли;
	
	Закрыть(ВозвращаемоеЗначение);
	
КонецПроцедуры



&НаСервере
Функция ДоступныеПримитивныеТипы()
	Возврат НаборТипов.НайтиПоЗначению("ПРИМИТИВНЫЕ") <> Неопределено;
КонецФункции

&НаСервере
Функция ДоступноХранилищеЗначений()
	Возврат НаборТипов.НайтиПоЗначению("ХРАНИЛИЩЕЗНАЧЕНИЙ") <> Неопределено;
КонецФункции

&НаСервере
Функция ДоступноNull()
	Возврат НаборТипов.НайтиПоЗначению("NULL") <> Неопределено;
КонецФункции

&НаСервере
Функция ДоступныСсылки()
	Возврат НаборТипов.НайтиПоЗначению("ССЫЛКИ") <> Неопределено;
КонецФункции

&НаСервере
Функция ДоступныСоставныеСсылки()
	Возврат НаборТипов.НайтиПоЗначению("СОСТАВНЫЕССЫЛКИ") <> Неопределено;
КонецФункции

&НаСервере
Функция ДоступенУникальныйИдентификатор()
	Возврат НаборТипов.НайтиПоЗначению("УНИКАЛЬНЫЙИДЕНТИФИКАТОР") <> Неопределено;
КонецФункции

&НаСервере
Функция ДоступныеКоллекцииЗначений()
	Возврат НаборТипов.НайтиПоЗначению("КОЛЛЕКЦИИЗНАЧЕНИЙ") <> Неопределено;
КонецФункции

&НаСервере
Функция ДоступенМоментВремени()
	Возврат НаборТипов.НайтиПоЗначению("МОМЕНТВРЕМЕНИ") <> Неопределено;
КонецФункции

&НаСервере
Функция ДоступенВыборТипаТип()
	Возврат НаборТипов.НайтиПоЗначению("ТИП") <> Неопределено;
КонецФункции

&НаСервере
Функция ДоступнаГраница()
	Возврат НаборТипов.НайтиПоЗначению("ГРАНИЦА") <> Неопределено;
КонецФункции

&НаСервере
Функция ДоступенСтандартныйПериод()
	Возврат НаборТипов.НайтиПоЗначению("СТАНДАРТНЫЙПЕРИОД") <> Неопределено;
КонецФункции

&НаСервере
Функция ДоступныСистемныеПеречисления()
	Возврат НаборТипов.НайтиПоЗначению("СИСТЕМНЫЕПЕРЕЧИСЛЕНИЯ") <> Неопределено;
КонецФункции

&НаСервере
Функция ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы, ИмяТипа, Картинка, Представление = "",
	СтрокаДерева = Неопределено, ЭтоГруппа = Ложь, Групповой = Ложь, НедоступенДляСоставногоТипа = Ложь)

	Если ЗначениеЗаполнено(Представление) Тогда
		ПредставлениеТипа=Представление;
	Иначе
		ПредставлениеТипа=ИмяТипа;
	КонецЕсли;

	Если ЗначениеЗаполнено(СтрокаПоиска) и Не Групповой Тогда
		Если СтрНайти(НРег(ПредставлениеТипа), НРег(СтрокаПоиска))=0 Тогда
			Возврат Неопределено;
		КонецЕсли;
	КонецЕсли;
	
	Если СтрокаДерева = Неопределено Тогда
		ЭлементДобавления=ДеревоТипов;
	Иначе
		ЭлементДобавления=СтрокаДерева;
	КонецЕсли;

	НоваяСтрока=ЭлементДобавления.ПолучитьЭлементы().Добавить();
	НоваяСтрока.Имя=ИмяТипа;
	НоваяСтрока.Представление=ПредставлениеТипа;
	НоваяСтрока.Картинка=Картинка;
	НоваяСтрока.ЭтоГруппа=ЭтоГруппа;
	НоваяСтрока.НедоступенДляСоставногоТипа=НедоступенДляСоставногоТипа;
	НоваяСтрока.Групповой = Групповой;
	
	Если ЗаполнятьВыбранныеТипы Тогда
		Попытка
			ТекТип=Тип(ИмяТипа);
		Исключение
			ТекТип=Неопределено;
		КонецПопытки;
		Если ТекТип<>Неопределено Тогда
			Если НачальныйТипДанных.СодержитТип(ТекТип) Тогда
				ВыбранныеТипы.Добавить(НоваяСтрока.Имя,,НоваяСтрока.НедоступенДляСоставногоТипа);
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;

	
	Возврат НоваяСтрока;
КонецФункции

&НаСервере
Процедура ЗаполнитьТипыПоВидуОбъекта(ВидОбъектовМетаданных, ПрефиксТипа, Картинка,ЗаполнятьВыбранныеТипы)
	КоллекцияОбъектов=Метаданные[ВидОбъектовМетаданных];
	
	СтрокаКоллекции=ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы,ПрефиксТипа,Картинка,ПрефиксТипа,,,Истина);
	
	Для Каждого ОбъектМетаданных Из КоллекцияОбъектов Цикл
		ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы,ПрефиксТипа+"."+ОбъектМетаданных.Имя, Картинка,ОбъектМетаданных.Имя,СтрокаКоллекции);
	КонецЦикла;
	
	УдалитьСтрокуДереваЕслиНетПодчиненныхПриПоиске(СтрокаКоллекции);
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьПримитивныеТипы(ЗаполнятьВыбранныеТипы)
	//ДобавитьТипВДеревоТипов("Произвольный", БиблиотекаКартинок.УИ_ПроизвольныйТип);
	Если ДоступныеПримитивныеТипы() Тогда
		ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы, "Число", БиблиотекаКартинок.УИ_Число);
		ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы, "Строка", БиблиотекаКартинок.УИ_Строка);
		ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы, "Дата", БиблиотекаКартинок.УИ_Дата);
		ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы, "Булево", БиблиотекаКартинок.УИ_Булево);
	КонецЕсли;
	Если ДоступноХранилищеЗначений() Тогда
		ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы, "ХранилищеЗначения", Новый Картинка);
	КонецЕсли;
	
	Если ДоступныеКоллекцииЗначений() Тогда
		ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы, "ТаблицаЗначений", БиблиотекаКартинок.УИ_ТаблицаЗначений);
		ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы, "СписокЗначений", БиблиотекаКартинок.УИ_СписокЗначений);
		ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы, "Массив", БиблиотекаКартинок.УИ_Массив);
	КонецЕсли;
	Если ДоступенВыборТипаТип() Тогда
		ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы, "Тип", БиблиотекаКартинок.ВыбратьТип);
		ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы, "ОписаниеТипов", БиблиотекаКартинок.ВыбратьТип);
	КонецЕсли;
	Если ДоступенМоментВремени() Тогда
		ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы, "МоментВремени", БиблиотекаКартинок.УИ_МоментВремени);
	КонецЕсли;
	Если ДоступнаГраница() Тогда
		ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы, "Граница", БиблиотекаКартинок.УИ_Граница);
	КонецЕсли;
	Если ДоступенУникальныйИдентификатор() Тогда
		ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы, "УникальныйИдентификатор",
			БиблиотекаКартинок.УИ_УникальныйИдентификатор);
	КонецЕсли;
	Если ДоступноNull() Тогда
		ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы,"Null", БиблиотекаКартинок.УИ_Null);
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТипыХарактеристик(ЗаполнятьВыбранныеТипы)
	Если Не ДоступныСоставныеСсылки() Тогда
		Возврат;
	КонецЕсли;
	//Характеристики
	ПланыВидов=Метаданные.ПланыВидовХарактеристик;
	Если ПланыВидов.Количество()=0 Тогда
		Возврат;
	КонецЕсли;
	
	СтрокаХарактеристик=ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы,"Характеристики", БиблиотекаКартинок.Папка,,,Истина,Истина);
	
	Для Каждого План Из ПланыВидов Цикл
		ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы,"Характеристика."+План.Имя,Новый Картинка,План.Имя,СтрокаХарактеристик,,,Истина);
	КонецЦикла;
	
	УдалитьСтрокуДереваЕслиНетПодчиненныхПриПоиске(СтрокаХарактеристик);

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьОпределяемыеТипы(ЗаполнятьВыбранныеТипы)
	Если Не ДоступныСоставныеСсылки() Тогда
		Возврат;
	КонецЕсли;
	
	//Характеристики
	Типы=Метаданные.ОпределяемыеТипы;
	Если Типы.Количество()=0 Тогда
		Возврат;
	КонецЕсли;
	
	СтрокаТипа=ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы,"ОпределяемыйТип", БиблиотекаКартинок.Папка,,,Истина, Истина);
	
	Для Каждого ОпределяемыйТип Из Типы Цикл
		ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы,"ОпределяемыйТип."+ОпределяемыйТип.Имя,Новый Картинка,ОпределяемыйТип.Имя,СтрокаТипа,,,Истина);
	КонецЦикла;
	УдалитьСтрокуДереваЕслиНетПодчиненныхПриПоиске(СтрокаТипа);
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТипыСистемныеПеречисления(ЗаполнятьВыбранныеТипы)
	Если Не ДоступныСистемныеПеречисления() Тогда
		Возврат;
	КонецЕсли;
	СтрокаТипа=ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы,"СистемныеПеречисления", БиблиотекаКартинок.Папка,"Системные перечисления",,Истина, Истина);

	ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы,"ВидДвиженияНакопления",БиблиотекаКартинок.УИ_ВидДвиженияНакопления,,СтрокаТипа);
	ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы,"ВидСчета",БиблиотекаКартинок.ПланСчетовОбъект,,СтрокаТипа);
	ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы,"ВидДвиженияБухгалтерии",БиблиотекаКартинок.ПланСчетов,,СтрокаТипа);
	ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы,"ИспользованиеАгрегатаРегистраНакопления",Новый Картинка,,СтрокаТипа);
	ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы,"ПериодичностьАгрегатаРегистраНакопления",Новый Картинка,,СтрокаТипа);
	
	УдалитьСтрокуДереваЕслиНетПодчиненныхПриПоиске(СтрокаТипа);
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьДеревоТипов(ЗаполнятьВыбранныеТипы=Ложь)
	ДеревоТипов.ПолучитьЭлементы().Очистить();
	ЗаполнитьПримитивныеТипы(ЗаполнятьВыбранныеТипы);
	ЗаполнитьТипыПоВидуОбъекта("Справочники", "СправочникСсылка",БиблиотекаКартинок.Справочник,ЗаполнятьВыбранныеТипы);
	ЗаполнитьТипыПоВидуОбъекта("Документы", "ДокументСсылка",БиблиотекаКартинок.Документ,ЗаполнятьВыбранныеТипы);
	ЗаполнитьТипыПоВидуОбъекта("ПланыВидовХарактеристик", "ПланВидовХарактеристикСсылка", БиблиотекаКартинок.ПланВидовХарактеристик,ЗаполнятьВыбранныеТипы);
	ЗаполнитьТипыПоВидуОбъекта("ПланыСчетов", "ПланСчетовСсылка", БиблиотекаКартинок.ПланСчетов,ЗаполнятьВыбранныеТипы);
	ЗаполнитьТипыПоВидуОбъекта("ПланыВидовРасчета", "ПланВидовРасчетаСсылка", БиблиотекаКартинок.ПланВидовРасчета,ЗаполнятьВыбранныеТипы);
	ЗаполнитьТипыПоВидуОбъекта("ПланыОбмена", "ПланОбменаСсылка", БиблиотекаКартинок.ПланОбмена,ЗаполнятьВыбранныеТипы);
	ЗаполнитьТипыПоВидуОбъекта("Перечисления", "ПеречислениеСсылка", БиблиотекаКартинок.Перечисление,ЗаполнятьВыбранныеТипы);
	ЗаполнитьТипыПоВидуОбъекта("БизнесПроцессы", "БизнесПроцессСсылка", БиблиотекаКартинок.БизнесПроцесс,ЗаполнятьВыбранныеТипы);
	ЗаполнитьТипыПоВидуОбъекта("Задачи", "ЗадачаСсылка", БиблиотекаКартинок.Задача,ЗаполнятьВыбранныеТипы);
	//ЗаполнитьТипыПоВидуОбъекта("ТочкиМаршрутаБизнесПроцессаСсылка", "ТочкаМаршрутаБизнесПроцессаСсылка");
	
	ЗаполнитьТипыХарактеристик(ЗаполнятьВыбранныеТипы);
	Попытка
		ЗаполнитьОпределяемыеТипы(ЗаполнятьВыбранныеТипы);
	Исключение
	КонецПопытки;
	Если ДоступныСоставныеСсылки() Тогда
		ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы, "ЛюбаяСсылка", Новый Картинка, "Любая ссылка");
	КонецЕсли;
	
	Если ДоступенСтандартныйПериод() Тогда
		ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы,"СтандартнаяДатаНачала", Новый Картинка, "Стандартный дата начала");
		ДобавитьТипВДеревоТипов(ЗаполнятьВыбранныеТипы,"СтандартныйПериод", Новый Картинка, "Стандартный период");
	КонецЕсли;
	ЗаполнитьТипыСистемныеПеречисления(ЗаполнятьВыбранныеТипы);
	
	УстановитьВыбранныеТипыВДереве(ДеревоТипов,ВыбранныеТипы);
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформление()
	// Группы нелья выбирать
	НовоеУО=УсловноеОформление.Элементы.Добавить();
	НовоеУО.Использование=Истина;
	УИ_ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(НовоеУО.Отбор,
		"Элементы.ДеревоТипов.ТекущиеДанные.ЭтоГруппа", Истина);
	Поле=НовоеУО.Поля.Элементы.Добавить();
	Поле.Использование=Истина;
	Поле.Поле=Новый ПолеКомпоновкиДанных("ДеревоТиповВыбран");

	Оформление=НовоеУО.Оформление.НайтиЗначениеПараметра(Новый ПараметрКомпоновкиДанных("Отображать"));
	Оформление.Использование=Истина;
	Оформление.Значение=Ложь;
	
	// Если строка неограниченная то нельзя менять допустимую длину строки
	НовоеУО=УсловноеОформление.Элементы.Добавить();
	НовоеУО.Использование=Истина;
	УИ_ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(НовоеУО.Отбор,
		"ДлинаСтроки", 0);
	Поле=НовоеУО.Поля.Элементы.Добавить();
	Поле.Использование=Истина;
	Поле.Поле=Новый ПолеКомпоновкиДанных("ДопустамаяДлинаСтрокиФиксированная");

	Оформление=НовоеУО.Оформление.НайтиЗначениеПараметра(Новый ПараметрКомпоновкиДанных("ТолькоПросмотр"));
	Оформление.Использование=Истина;
	Оформление.Значение=Истина;
	
	Если РежимВыбора Тогда
		НовоеУО=УсловноеОформление.Элементы.Добавить();
		НовоеУО.Использование=Истина;
		УИ_ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(НовоеУО.Отбор,
			"Элементы.ДеревоТипов.ТекущиеДанные.Групповой", Истина);
		Поле=НовоеУО.Поля.Элементы.Добавить();
		Поле.Использование=Истина;
		Поле.Поле=Новый ПолеКомпоновкиДанных("ДеревоТиповВыбран");

		Оформление=НовоеУО.Оформление.НайтиЗначениеПараметра(Новый ПараметрКомпоновкиДанных("Отображать"));
		Оформление.Использование=Истина;
		Оформление.Значение=Ложь;

	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура УдалитьСтрокуДереваЕслиНетПодчиненныхПриПоиске(СтрокаДерева)
	Если Не ЗначениеЗаполнено(СтрокаПоиска) Тогда
		Возврат;
	КонецЕсли;
	Если СтрокаДерева.ПолучитьЭлементы().Количество()=0 Тогда
		ДеревоТипов.ПолучитьЭлементы().Удалить(СтрокаДерева);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура РазвернутьЭлементыДерева()
	Для каждого СтрокаДерева Из ДеревоТипов.ПолучитьЭлементы() Цикл 
		Элементы.ДеревоТипов.Развернуть(СтрокаДерева.ПолучитьИдентификатор());
	КонецЦикла;
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьВыбранныеТипыВДереве(СтрокаДерева,ВыбранныеТипы)
	Для Каждого Стр ИЗ СтрокаДерева.ПолучитьЭлементы() Цикл
		Стр.Выбран=ВыбранныеТипы.НайтиПоЗначению(Стр.Имя)<>Неопределено;
		
		УстановитьВыбранныеТипыВДереве(Стр, ВыбранныеТипы);
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьВыбранныйТип(СтрокаДереваИлиТип)
	Если ТипЗнч(СтрокаДереваИлиТип)=Тип("Строка") Тогда
		ИмяТипа=СтрокаДереваИлиТип;
		НедоступенДляСоставногоТипа=Ложь;
	ИначеЕсли ТипЗнч(СтрокаДереваИлиТип)=Тип("ЭлементСпискаЗначений") Тогда
		ИмяТипа=СтрокаДереваИлиТип.Значение;
		НедоступенДляСоставногоТипа=СтрокаДереваИлиТип.Пометка;
	Иначе
		ИмяТипа=СтрокаДереваИлиТип.Имя;
		НедоступенДляСоставногоТипа=СтрокаДереваИлиТип.НедоступенДляСоставногоТипа;
	КонецЕсли;
	
	Если ВыбранныеТипы.НайтиПоЗначению(ИмяТипа)=Неопределено Тогда
		ВыбранныеТипы.Добавить(ИмяТипа,,НедоступенДляСоставногоТипа);
	КонецЕсли;
КонецПроцедуры
&НаКлиенте
Процедура ДеревоТиповВыбранПриИзмененииЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	Ответ=РезультатВопроса;
	
	Если Ответ=КодВозвратаДиалога.Нет Тогда
		ДополнительныеПараметры.ТекСтрока.Выбран=Ложь;
		Возврат;
	КОнецЕсли;

	ВыбранныеТипы.Очистить();
	ДеревоТиповВыбранПриИзмененииФрагмент(ДополнительныеПараметры.ТекСтрока);
КонецПроцедуры
&НаКлиенте
Процедура ДеревоТиповВыбранПриИзмененииЗавершениеБылЗапрещенныйДляСоставногоТип(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	Ответ=РезультатВопроса;
	
	Если Ответ=КодВозвратаДиалога.Нет Тогда
		ДополнительныеПараметры.ТекСтрока.Выбран=Ложь;
		Возврат;
	КОнецЕсли;

	МассивУдаляемыхЭлементов=Новый Массив;
	Для Каждого Эл Из ВыбранныеТипы Цикл 
		Если Эл.Пометка Тогда
			МассивУдаляемыхЭлементов.Добавить(Эл);
		КонецЕсли;
	КонецЦикла;
	
	Для Каждого Эл Из  МассивУдаляемыхЭлементов Цикл
		ВыбранныеТипы.Удалить(Эл);
	КонецЦикла;
	
	ДеревоТиповВыбранПриИзмененииФрагмент(ДополнительныеПараметры.ТекСтрока);
КонецПроцедуры

&НаКлиенте
Процедура ДеревоТиповВыбранПриИзмененииФрагмент(ТекСтрока) Экспорт
		
	Если ТекСтрока.Выбран Тогда
		ДобавитьВыбранныйТип(ТекСтрока);
	КонецЕсли;

	Если ВыбранныеТипы.Количество()=0 Тогда
		ДобавитьВыбранныйТип("Строка");
	КонецЕсли;
	
	УстановитьВыбранныеТипыВДереве(ДеревоТипов,ВыбранныеТипы);
КонецПроцедуры


&НаСервере
Процедура ЗаполнитьДанныеКвалификаторовПоПервоначальномуТипуДанных(НачальныйТипДанных)
	ДлинаЧисла=НачальныйТипДанных.КвалификаторыЧисла.Разрядность;
	ТочностьЧисла=НачальныйТипДанных.КвалификаторыЧисла.РазрядностьДробнойЧасти;
	НеотрицательноеЧисло= НачальныйТипДанных.КвалификаторыЧисла.ДопустимыйЗнак=ДопустимыйЗнак.Неотрицательный;
	
	ДлинаСтроки=НачальныйТипДанных.КвалификаторыСтроки.Длина;
	НеограниченнаяДлинаСтроки=Не ЗначениеЗаполнено(ДлинаСтроки);
	ДопустамаяДлинаСтрокиФиксированная=НачальныйТипДанных.КвалификаторыСтроки.ДопустимаяДлина=ДопустимаяДлина.Фиксированная;

	Если НачальныйТипДанных.КвалификаторыДаты.ЧастиДаты=ЧастиДаты.Время Тогда
		СоставДаты= 1;
	ИначеЕсли НачальныйТипДанных.КвалификаторыДаты.ЧастиДаты=ЧастиДаты.ДатаВремя Тогда
		СоставДаты=2;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти