#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ПрефиксОкончаниеКолонокКонтейнера = "____Контейнер__";

	Если Параметры.Свойство("СериализоватьВXML") Тогда
		//@skip-check unknown-form-parameter-access
		СериализоватьВXML = Параметры.СериализоватьВXML;
	КонецЕсли;
	
	Таблица = Неопределено;
	Если Параметры.Свойство("ТаблицаЗначенийСтрокой") Тогда
		//@skip-check unknown-form-parameter-access
		Таблица = ТаблицаЗначенийИзСтроковогоПредставления(Параметры.ТаблицаЗначенийСтрокой, СериализоватьВXML);
	ИначеЕсли Параметры.Свойство("ХранилищеКонтейнераЗначения") Тогда 
		ВозвратХранилищаДляКонтейнераЗначения = Истина;
		
		//@skip-check unknown-form-parameter-access
		ХранилищеКонтейнера = Параметры.ХранилищеКонтейнераЗначения; //см. УИ_ОбщегоНазначенияКлиентСервер.НовыйХранилищеЗначенияТаблицыЗначений
		
		СериализоватьВXML = Ложь;
		Если ХранилищеКонтейнера <> Неопределено Тогда
			Таблица = УИ_ОбщегоНазначения.ЗначениеИзХранилищаКонтейнераТаблицыЗначений(ХранилищеКонтейнера);
		КонецЕсли;
	ИначеЕсли Параметры.Свойство("ХранилищеКонтейнераЗначенияДерева") Тогда 
		ВозвратХранилищаДляКонтейнераЗначения = Истина;
		ЭтоДерево = Истина;
		
		//@skip-check unknown-form-parameter-access
		ХранилищеКонтейнера = Параметры.ХранилищеКонтейнераЗначенияДерева; //см. УИ_ОбщегоНазначенияКлиентСервер.НовыйХранилищеЗначенияТаблицыЗначений
		
		СериализоватьВXML = Ложь;
		Если ХранилищеКонтейнера <> Неопределено Тогда
			Таблица = УИ_ОбщегоНазначения.ЗначениеИзХранилищаКонтейнераДереваЗначений(ХранилищеКонтейнера);
		КонецЕсли;
	КонецЕсли;

	Если Таблица = Неопределено Тогда
		Если ЭтоДерево Тогда
			Таблица = Новый ДеревоЗначений;
		Иначе
			Таблица = Новый ТаблицаЗначений;
		КонецЕсли;
	КонецЕсли;
	Если ЭтоДерево Тогда
		Заголовок = "Редактор дерева значения";
	Иначе
		Заголовок = "Редактор таблицы значения"
	КонецЕсли;
	ДобавитьКорневойЭлементИРеквизитТаблицы();	

	ЗаполнитьКолонкиТаблицыЗначений(Таблица);
	СоздатьКолонкиТаблицыЗначенийФормы();
	Если ЭтоДерево Тогда
		ЗаполнитьДеревоЗначенийФормыПоДереву(Таблица);
	Иначе
		ЗаполнитьТаблицуЗначенийФормыПоТаблице(Таблица);
	КонецЕсли;
	
	Если КолонкиТаблицы.Количество() = 0 Тогда
		Элементы.ГруппаКолонкиТаблицы.Показать();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыКолонкиТаблицы

&НаКлиенте
Процедура КолонкиТаблицыПередОкончаниемРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования, Отказ)
	Если ОтменаРедактирования Тогда
		Возврат;
	КонецЕсли;
	ТекДанные = Элементы.КолонкиТаблицы.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ИмяКолонки = ТекДанные.Имя;

	Если Не УИ_ОбщегоНазначенияКлиентСервер.ИмяПеременнойКорректно(ИмяКолонки) Тогда
		ПоказатьПредупреждение( ,
			УИ_ОбщегоНазначенияКлиентСервер.ТекстПредупрежденияОНерпавильномИмениПеременной(),
			, Заголовок);
		Отказ = Истина;
		Возврат;
	КонецЕсли;

	СтрокиИмени = КолонкиТаблицы.НайтиСтроки(Новый Структура("Имя", ИмяКолонки));
	Если СтрокиИмени.Количество() > 1 Тогда
		ПоказатьПредупреждение( , "Колонка с таким именем уже есть! Введите другое имя.", , Заголовок);
		Отказ = Истина;
		Возврат;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура КолонкиТаблицыТипЗначенияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ТекДанные=Элементы.КолонкиТаблицы.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;

	СтандартнаяОбработка = Ложь;
	ТекСтрока=Элементы.КолонкиТаблицы.ТекущаяСтрока;

	УИ_ОбщегоНазначенияКлиент.РедактироватьТип(ТекДанные.ТипЗначения, 1, СтандартнаяОбработка, ЭтотОбъект,
		Новый ОписаниеОповещения("КолонкиТаблицыТипЗначенияНачалоВыбораЗавершение", ЭтотОбъект,
		Новый Структура("ТекСтрока", ТекСтрока)));
КонецПроцедуры

&НаКлиенте
Процедура КолонкиТаблицыПослеУдаления(Элемент)
	СоздатьКолонкиТаблицыЗначенийФормы();
КонецПроцедуры

&НаКлиенте
Процедура КолонкиТаблицыПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	Если ОтменаРедактирования Тогда
		Возврат;
	КонецЕсли;
	
	ТекДанные = Элементы.КолонкиТаблицы.ТекущиеДанные;
	ТекДанные.ИмяДляПоиска = НРег(ТекДанные.Имя);

	Элементы.ТаблицаЗначений.Доступность = Ложь;
	ПодключитьОбработчикОжидания("СоздатьКолонкиТаблицыЗначенийФормыОбработчикОжидания", 0.1, Истина);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТаблицаЗначений

&НаКлиенте 
Процедура Подключаемый_ПолеТаблицыЗначенийПриИзменении(Элемент)
	ТекДанные = Элементы.ТаблицаЗначений.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		ВозвраТ;
	КонецЕсли;
	
	СтрокаКолонкиТаблицы = СтрокаКолонкиТаблицы(КолонкиТаблицы, Сред(НРег(Элемент.Имя), СтрДлина("таблицазначений")+1));
	Если СтрокаКолонкиТаблицы = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыОбработчика = УИ_ОбщегоНазначенияКлиент.НовыйПараметрыОбработчикаСобытияПриИзменении(ЭтотОбъект,
																								  Элемент,
																								  "Значение");
	ПараметрыОбработчика.ДоступенКонтейнер = Истина;
	ПараметрыОбработчика.СтруктураХраненияЗначения = ТекДанные;
	
	СтруктураХраненияКолонкиТаблицыНаФорме = СтруктураХраненияКолонкиТаблицыНаФорме(СтрокаКолонкиТаблицы.Имя);
	ЗаполнитьЗначенияСвойств(ПараметрыОбработчика, СтруктураХраненияКолонкиТаблицыНаФорме);

	УИ_ОбщегоНазначенияКлиент.ПолеФормыОбработчикПриИзменении(ПараметрыОбработчика);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПолеТаблицыЗначенийНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ТекДанные = Элементы.ТаблицаЗначений.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		ВозвраТ;
	КонецЕсли;

	СтрокаКолонкиТаблицы = СтрокаКолонкиТаблицы(КолонкиТаблицы, Сред(НРег(Элемент.Имя), СтрДлина("таблицазначений")+1));
	Если СтрокаКолонкиТаблицы = Неопределено Тогда
		СтандартнаяОбработка = Ложь;
		Возврат;
	КонецЕсли;

	ПараметрыОбработчика = УИ_ОбщегоНазначенияКлиент.НовыйПараметрыОбработчикаСобытияНачалоВыбораЗначения(ЭтотОбъект,
																										  Элемент,
																										  СтрокаКолонкиТаблицы.Имя);
	ПараметрыОбработчика.ДоступенКонтейнер = Истина;
	ПараметрыОбработчика.Значение = ТекДанные[СтрокаКолонкиТаблицы.Имя];
	ПараметрыОбработчика.СтруктураХраненияЗначения = ТекДанные;
	ПараметрыОбработчика.НаборТипов = УИ_ОбщегоНазначенияКлиентСервер.ВсеНаборыТиповДляРедактирования();
	ПараметрыОбработчика.ТекущееОписаниеТиповЗначения = СтрокаКолонкиТаблицы.ТипЗначения;

	СтруктураХраненияКолонкиТаблицыНаФорме = СтруктураХраненияКолонкиТаблицыНаФорме(СтрокаКолонкиТаблицы.Имя);
	ЗаполнитьЗначенияСвойств(ПараметрыОбработчика, СтруктураХраненияКолонкиТаблицыНаФорме);
	УИ_ОбщегоНазначенияКлиент.ПолеФормыОбработчикНачалоВыбораЗначения(ПараметрыОбработчика, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПолеТаблицыЗначенийОчистка(Элемент, СтандартнаяОбработка)
	ТекДанные = Элементы.ТаблицаЗначений.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	СтрокаКолонкиТаблицы = СтрокаКолонкиТаблицы(КолонкиТаблицы, Сред(НРег(Элемент.Имя), СтрДлина("таблицазначений")+1));
	Если СтрокаКолонкиТаблицы = Неопределено Тогда
		СтандартнаяОбработка = Ложь;
		Возврат;
	КонецЕсли;

	ПараметрыОбработчика = УИ_ОбщегоНазначенияКлиент.НовыйПараметрыОбработчикаСобытияОчистка(ЭтотОбъект,
																							 Элемент,
																							 СтрокаКолонкиТаблицы.Имя);
	ПараметрыОбработчика.ДоступенКонтейнер = Истина;
	ПараметрыОбработчика.СтруктураХраненияЗначения = ТекДанные;
	ПараметрыОбработчика.ТекущееОписаниеТиповЗначения = СтрокаКолонкиТаблицы.ТипЗначения;
	
	СтруктураХраненияКолонкиТаблицыНаФорме = СтруктураХраненияКолонкиТаблицыНаФорме(СтрокаКолонкиТаблицы.Имя);
	ЗаполнитьЗначенияСвойств(ПараметрыОбработчика, СтруктураХраненияКолонкиТаблицыНаФорме);
	
	УИ_ОбщегоНазначенияКлиент.ПолеФормыОбработчикОчистка(ПараметрыОбработчика, СтандартнаяОбработка);
КонецПроцедуры


#КонецОбласти

#Область ОбработчикиКомандФормы
&НаКлиенте
Процедура Применить(Команда)
	Если ЭтоДерево Тогда
		СтруктураРезультата=РезультатДеревоЗначенийВХранилище();
	Иначе
		СтруктураРезультата=РезультатТаблицаЗначенийВСтроку();
	КонецЕсли;
	
	Закрыть(СтруктураРезультата);	
КонецПроцедуры
#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиентеНаСервереБезКонтекста
Функция СтрокаКолонкиТаблицы(Колонки, Имя)
	Поиск = Новый Структура;
	Поиск.Вставить("ИмяДляПоиска", НРег(Имя));
	
	НайденныеСтроки = Колонки.НайтиСтроки(Поиск);
	Если НайденныеСтроки.Количество() = 0 Тогда
		Возврат Неопределено;
	Иначе
		Возврат НайденныеСтроки[0];
	КонецЕсли;
КонецФункции

&НаКлиенте
Процедура СоздатьКолонкиТаблицыЗначенийФормыОбработчикОжидания()
	СоздатьКолонкиТаблицыЗначенийФормы();
	Элементы.ТаблицаЗначений.Доступность = Истина;
КонецПроцедуры

&НаСервереБезКонтекста
Функция ТаблицаЗначенийИзСтроковогоПредставления(СтроковоеПредставлениеТаблицы, СериализоватьвXML)

	Если СериализоватьВXML Тогда
		Попытка
			Таблица=УИ_ОбщегоНазначения.ЗначениеИзСтрокиXML(СтроковоеПредставлениеТаблицы);
		Исключение
			Таблица=Новый ТаблицаЗначений;
		КонецПопытки;
	Иначе
		Попытка
			Таблица=ЗначениеИзСтрокиВнутр(СтроковоеПредставлениеТаблицы);
		Исключение
			Таблица=Новый ТаблицаЗначений;
		КонецПопытки;
	КонецЕсли;
	Возврат Таблица;

КонецФункции

&НаСервере
Процедура ЗаполнитьКолонкиТаблицыЗначений(Таблица)
	КолонкиТаблицы.Очистить();

	Для Каждого Колонка Из Таблица.Колонки Цикл
		НС=КолонкиТаблицы.Добавить();
		НС.Имя=Колонка.Имя;
		НС.ИмяДляПоиска = НРег(Колонка.Имя);
		НС.ТипЗначения=Колонка.ТипЗначения;
	КонецЦикла;
КонецПроцедуры

&НаСервереБезКонтекста
Процедура УдалитьЗначениеИзМассива(Массив, Значение)
	Индекс = Массив.Найти(Значение);
	Если Индекс = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Массив.Удалить(Индекс);
КонецПроцедуры

&НаСервере
Функция ИмяВспомогательнойКолонкиТаблицы(ИмяПоля, Суффикс)
	Возврат ПрефиксОкончаниеКолонокКонтейнера + ИмяПоля + Суффикс + ПрефиксОкончаниеКолонокКонтейнера
КонецФункции

&НаСервере
Процедура СоздатьКолонкиТаблицыЗначенийФормы(ТекущаяСтрокаКолонки = Неопределено)
	ТипХранимыеВКонтейнере = УИ_ОбщегоНазначенияКлиентСервер.ТипыЗначенийХранимыеВКонтейнерах();
	
	МассивУдаляемыхРеквизитов=Новый Массив;
	МассивДобавляемыхРеквизитов=Новый Массив;
	
	МассивТекущихКолонокТаблицы=ПолучитьРеквизиты(ИмяРеквизитаХранилища);
	
	УжеСозданныеКолонки=Новый Структура;

	Для Каждого ТекРеквизит Из МассивТекущихКолонокТаблицы Цикл
		МассивУдаляемыхРеквизитов.Добавить(ИмяРеквизитаХранилища + "." + НРег(ТекРеквизит.Имя));
		Если СтрНачинаетсяС(ТекРеквизит.Имя, ПрефиксОкончаниеКолонокКонтейнера) И СтрЗаканчиваетсяНа(ТекРеквизит.Имя,
																									 ПрефиксОкончаниеКолонокКонтейнера) Тогда
			Продолжить;
		КонецЕсли;
		УжеСозданныеКолонки.Вставить(ТекРеквизит.Имя, ТекРеквизит);

	КонецЦикла;
	КолонкиДляПриведенияТипов=Новый Массив;

	СтруктурыХраненияЗначенийПоляКолонок = Новый Структура;

	Для Каждого ТекКолонка Из КолонкиТаблицы Цикл
		СтруктурыХраненияЗначенийПоляКолонок.Вставить(ТекКолонка.Имя,
													  СтруктураХраненияКолонкиТаблицыНаФорме(ТекКолонка.Имя));
		Если УжеСозданныеКолонки.Свойство(ТекКолонка.Имя) Тогда
			Если ТекКолонка.ТипЗначения <> УжеСозданныеКолонки[ТекКолонка.Имя].ТипЗначения Тогда
				КолонкиДляПриведенияТипов.Добавить(ТекКолонка);
			КонецЕсли;

			УдалитьЗначениеИзМассива(МассивУдаляемыхРеквизитов, ИмяРеквизитаХранилища + "." + НРег(ТекКолонка.Имя));
			УдалитьЗначениеИзМассива(МассивУдаляемыхРеквизитов, ИмяРеквизитаХранилища
																+ "."
																+ НРег(ИмяВспомогательнойКолонкиТаблицы(ТекКолонка.Имя,
																										УИ_ОбщегоНазначенияКлиентСервер.СуффиксИмениПоляХраненияКонтейнераДляПоляСКонтейнером())));
			УдалитьЗначениеИзМассива(МассивУдаляемыхРеквизитов, ИмяРеквизитаХранилища
																+ "."
																+ НРег(ИмяВспомогательнойКолонкиТаблицы(ТекКолонка.Имя,
																										УИ_ОбщегоНазначенияКлиентСервер.СуффиксИмениПоляХраненияТипаЗначенияДляПоляСКонтейнером())));
			УдалитьЗначениеИзМассива(МассивУдаляемыхРеквизитов, ИмяРеквизитаХранилища
																+ "."
																+ НРег(ИмяВспомогательнойКолонкиТаблицы(ТекКолонка.Имя,
																										УИ_ОбщегоНазначенияКлиентСервер.СуффиксИмениПоляХраненияПредставленияТипаЗначенияДляПоляСКонтейнером())));

		Иначе
			МассивДобавляемыхРеквизитов.Добавить(Новый РеквизитФормы(ТекКолонка.Имя, Новый ОписаниеТипов,
				ИмяРеквизитаХранилища, , Истина));
			МассивДобавляемыхРеквизитов.Добавить(Новый РеквизитФормы(ИмяВспомогательнойКолонкиТаблицы(ТекКолонка.Имя,
																									  УИ_ОбщегоНазначенияКлиентСервер.СуффиксИмениПоляХраненияКонтейнераДляПоляСКонтейнером()),
				Новый ОписаниеТипов, ИмяРеквизитаХранилища, , Истина));
			МассивДобавляемыхРеквизитов.Добавить(Новый РеквизитФормы(ИмяВспомогательнойКолонкиТаблицы(ТекКолонка.Имя,
																									  УИ_ОбщегоНазначенияКлиентСервер.СуффиксИмениПоляХраненияТипаЗначенияДляПоляСКонтейнером()),
				Новый ОписаниеТипов("ОписаниеТипов"), ИмяРеквизитаХранилища, , Истина));
			МассивДобавляемыхРеквизитов.Добавить(Новый РеквизитФормы(ИмяВспомогательнойКолонкиТаблицы(ТекКолонка.Имя,
																									  УИ_ОбщегоНазначенияКлиентСервер.СуффиксИмениПоляХраненияПредставленияТипаЗначенияДляПоляСКонтейнером()),
				УИ_ОбщегоНазначенияКлиентСервер.ОписаниеТипаСтрока(0), ИмяРеквизитаХранилища, , Истина));

		КонецЕсли;
	КонецЦикла;

	ИзменитьРеквизиты(МассивДобавляемыхРеквизитов, МассивУдаляемыхРеквизитов);

	Для Каждого ТекКолонка Из КолонкиТаблицы Цикл
		ОписаниеЭлемента=УИ_РаботаСФормами.НовыйОписаниеРеквизитаЭлемента();
		ОписаниеЭлемента.Вставить("Имя", ТекКолонка.Имя);
		ОписаниеЭлемента.Вставить("ПутьКДанным", ИмяРеквизитаХранилища+"." + ТекКолонка.Имя);
		ОписаниеЭлемента.Вставить("РодительЭлемента", Элементы.ТаблицаЗначений);

		ОписаниеЭлемента.Действия.Вставить("ПриИзменении", "Подключаемый_ПолеТаблицыЗначенийПриИзменении");
		ОписаниеЭлемента.Действия.Вставить("НачалоВыбора", "Подключаемый_ПолеТаблицыЗначенийНачалоВыбора");
		ОписаниеЭлемента.Действия.Вставить("Очистка", "Подключаемый_ПолеТаблицыЗначенийОчистка");

		ЭлементНовый = УИ_РаботаСФормами.СоздатьЭлементПоОписанию(ЭтотОбъект, ОписаниеЭлемента);
		ЭлементНовый.ВыбиратьТип = Ложь;
		ЭлементНовый.ВыборГруппИЭлементов = ГруппыИЭлементы.ГруппыИЭлементы;
		ЭлементНовый.ОграничениеТипа = ТекКолонка.ТипЗначения;
		ЭлементНовый.КнопкаВыбора = Истина;
		ЭлементНовый.КнопкаОчистки = Истина;

	КонецЦикла;

	Для Каждого ТекКолонка Из КолонкиДляПриведенияТипов Цикл
		СтруктураХраненияКолонки = СтруктурыХраненияЗначенийПоляКолонок[ТекКолонка.Имя];
		Для Каждого СтрокаТЗ Из ЭтотОбъект[ИмяРеквизитаХранилища] Цикл
			ЗначениеПоля = УИ_ОбщегоНазначенияКлиентСервер.ЗначениеПоляСКонтейнеромЗначения(СтрокаТЗ,
																							СтруктураХраненияКолонки);
			НовоеЗначениеПоля = ТекКолонка.ТипЗначения.ПривестиЗначение(ЗначениеПоля);

			Если ЗначениеПоля <> НовоеЗначениеПоля Или ТипЗнч(ЗначениеПоля) <> ТипЗнч(НовоеЗначениеПоля) Тогда
				УИ_ОбщегоНазначенияКлиентСервер.УстановитьЗначениеПоляСКонтейнером(СтрокаТЗ,
																				   СтруктураХраненияКолонки,
																				   НовоеЗначениеПоля);
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
КонецПроцедуры


&НаСервере
Процедура ЗаполнитьТаблицуЗначенийФормыПоТаблице(ТаблицаИсточник)
	ТаблицаЗначений = ЭтотОбъект[ИмяРеквизитаХранилища];
	ТаблицаЗначений.Очистить();

	СтруктурыХраненияКолонокТаблицыНаФорме = Новый Структура;

	Для Каждого СтрокаКолонки Из КолонкиТаблицы Цикл
		СтруктурыХраненияКолонокТаблицыНаФорме.Вставить(СтрокаКолонки.Имя,
														СтруктураХраненияКолонкиТаблицыНаФорме(СтрокаКолонки.Имя));
	КонецЦикла;

	Для Каждого Стр Из ТаблицаИсточник Цикл
		НС=ТаблицаЗначений.Добавить();

		Для Каждого СтрокаКолонки Из КолонкиТаблицы Цикл
			УИ_ОбщегоНазначенияКлиентСервер.УстановитьЗначениеПоляСКонтейнером(НС,
																			   СтруктурыХраненияКолонокТаблицыНаФорме[СтрокаКолонки.Имя],
																			   Стр[СтрокаКолонки.Имя]);
		КонецЦикла;
		
		//ЗаполнитьЗначенияСвойств(НС, Стр);
	КонецЦикла;
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ПолучитьМодификаторыТипа(ТипЗначения)

	маКвалификаторы = Новый Массив;

	Если ТипЗначения.СодержитТип(Тип("Строка")) Тогда
		стрКвалификаторыСтроки = "Длина " + ТипЗначения.КвалификаторыСтроки.Длина;
		маКвалификаторы.Добавить(Новый Структура("Тип, Квалификаторы", "Строка", стрКвалификаторыСтроки));
	КонецЕсли;

	Если ТипЗначения.СодержитТип(Тип("Дата")) Тогда
		стрКвалификаторыДаты = ТипЗначения.КвалификаторыДаты.ЧастиДаты;
		маКвалификаторы.Добавить(Новый Структура("Тип, Квалификаторы", "Дата", стрКвалификаторыДаты));
	КонецЕсли;

	Если ТипЗначения.СодержитТип(Тип("Число")) Тогда
		стрКвалификаторыДаты = "Знак " + ТипЗначения.КвалификаторыЧисла.ДопустимыйЗнак + " "
			+ ТипЗначения.КвалификаторыЧисла.Разрядность + "." + ТипЗначения.КвалификаторыЧисла.РазрядностьДробнойЧасти;
		маКвалификаторы.Добавить(Новый Структура("Тип, Квалификаторы", "Число", стрКвалификаторыДаты));
	КонецЕсли;

	фНуженЗаголовок = маКвалификаторы.Количество() > 1;

	стрКвалификаторы = "";
	Для Каждого стКвалификаторы Из маКвалификаторы Цикл
		стрКвалификаторы = ?(фНуженЗаголовок, стКвалификаторы.Тип + ": ", "") + стКвалификаторы.Квалификаторы + "; ";
	КонецЦикла;

	Возврат стрКвалификаторы;

КонецФункции

&НаКлиенте
Процедура КолонкиТаблицыТипЗначенияНачалоВыбораЗавершение(Результат, ДополнительныеПараметры) Экспорт
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;

	ТекДанные=КолонкиТаблицы.НайтиПоИдентификатору(ДополнительныеПараметры.ТекСтрока);
	ТекДанные.ТипЗначения=Результат;
	ТекДанные.Квалификаторы=ПолучитьМодификаторыТипа(ТекДанные.ТипЗначения);
	
КонецПроцедуры

&НаСервере
Функция РезультатДеревоЗначенийВХранилище()
	ДеревоРезультата = Новый ДеревоЗначений();

	СтруктураСтруктурХраненияПоляПоИменам = Новый Структура;

	Для Каждого ТекСтрокаКолонки Из КолонкиТаблицы Цикл
		ДеревоРезультата.Колонки.Добавить(ТекСтрокаКолонки.Имя, ТекСтрокаКолонки.ТипЗначения);

		СтруктураСтруктурХраненияПоляПоИменам.Вставить(ТекСтрокаКолонки.Имя,
													   СтруктураХраненияКолонкиТаблицыНаФорме(ТекСтрокаКолонки.Имя));
	КонецЦикла;

	ПрочитатьСтрокуДереваФормыВДеревоРезультата(ЭтотОбъект[ИмяРеквизитаХранилища],
												ДеревоРезультата,
												СтруктураСтруктурХраненияПоляПоИменам);
												
	Если ВозвратХранилищаДляКонтейнераЗначения Тогда
		Возврат УИ_ОбщегоНазначения.ЗначениеХранилищаКонтейнераДереваЗначений(ДеревоРезультата);	
	Иначе

		СтруктураРезультата=Новый Структура;
		Если СериализоватьВXML Тогда
			СтруктураРезультата.Вставить("Значение", УИ_ОбщегоНазначения.ЗначениеВСтрокуXML(ДеревоРезультата));
		Иначе
			СтруктураРезультата.Вставить("Значение", ЗначениеВСтрокуВнутр(ДеревоРезультата));
		КонецЕсли;
		СтруктураРезультата.Вставить("Представление", СтрШаблон("Строк: %1 Колонок: %2",
																ДеревоРезультата.Строки.Количество(),
																ДеревоРезультата.Колонки.Количество()));
		СтруктураРезультата.Вставить("КоличествоСтрок", ДеревоРезультата.Строки.Количество());
		СтруктураРезультата.Вставить("КоличествоКолонок", ДеревоРезультата.Колонки.Количество());
		Возврат СтруктураРезультата;
	КонецЕсли;
	
КонецФункции

// Прочитать строку дерева формы в дерево результата.
// 
// Параметры:
//  СтрокаДереваФормы - ДанныеФормыДерево, ДанныеФормыЭлементДерева- Строка дерева формы
//  СтрокаДереваРезультата - ДеревоЗначений, СтрокаДереваЗначений -  Строка дерева результата
//  СтруктураСтруктурХраненияПоляПоИменам - Структура -  Структура структур хранения поля по именам
&НаСервере
Процедура ПрочитатьСтрокуДереваФормыВДеревоРезультата(СтрокаДереваФормы, СтрокаДереваРезультата,
	СтруктураСтруктурХраненияПоляПоИменам)

	Для Каждого СтрокаТаблицыФормы Из СтрокаДереваФормы.ПолучитьЭлементы() Цикл
		НоваяСтрока = СтрокаДереваРезультата.Строки.Добавить();

		Для Каждого ТекСтрокаКолонки Из КолонкиТаблицы Цикл
			НоваяСтрока[ТекСтрокаКолонки.Имя] = УИ_ОбщегоНазначенияКлиентСервер.ЗначениеПоляСКонтейнеромЗначения(СтрокаТаблицыФормы,
																												 СтруктураСтруктурХраненияПоляПоИменам[ТекСтрокаКолонки.Имя]);
		КонецЦикла;

		ПрочитатьСтрокуДереваФормыВДеревоРезультата(СтрокаТаблицыФормы,
													НоваяСтрока,
													СтруктураСтруктурХраненияПоляПоИменам);
	КонецЦикла;

КонецПроцедуры

&НаСервере
Функция РезультатТаблицаЗначенийВСтроку()
	ТаблицаРезультата = Новый ТаблицаЗначений;

	СтруктураСтруктурХраненияПоляПоИменам = Новый Структура;

	Для Каждого ТекСтрокаКолонки Из КолонкиТаблицы Цикл
		ТаблицаРезультата.Колонки.Добавить(ТекСтрокаКолонки.Имя, ТекСтрокаКолонки.ТипЗначения);

		СтруктураСтруктурХраненияПоляПоИменам.Вставить(ТекСтрокаКолонки.Имя,
													   СтруктураХраненияКолонкиТаблицыНаФорме(ТекСтрокаКолонки.Имя));
	КонецЦикла;

	Для Каждого СтрокаТаблицыФормы Из ЭтотОбъект[ИмяРеквизитаХранилища] Цикл
		НоваяСтрока = ТаблицаРезультата.Добавить();

		Для Каждого ТекСтрокаКолонки Из КолонкиТаблицы Цикл
			НоваяСтрока[ТекСтрокаКолонки.Имя] = УИ_ОбщегоНазначенияКлиентСервер.ЗначениеПоляСКонтейнеромЗначения(СтрокаТаблицыФормы,
																												 СтруктураСтруктурХраненияПоляПоИменам[ТекСтрокаКолонки.Имя]);
		КонецЦикла;
	КонецЦикла;
	
	Если ВозвратХранилищаДляКонтейнераЗначения Тогда
		Возврат УИ_ОбщегоНазначения.ЗначениеХранилищаКонтейнераТаблицыЗначений(ТаблицаРезультата);	
	Иначе

		СтруктураРезультата=Новый Структура;
		Если СериализоватьВXML Тогда
			СтруктураРезультата.Вставить("Значение", УИ_ОбщегоНазначения.ЗначениеВСтрокуXML(ТаблицаРезультата));
		Иначе
			СтруктураРезультата.Вставить("Значение", ЗначениеВСтрокуВнутр(ТаблицаРезультата));
		КонецЕсли;
		СтруктураРезультата.Вставить("Представление", СтрШаблон("Строк: %1 Колонок: %2",
																ТаблицаРезультата.Количество(),
																ТаблицаРезультата.Колонки.Количество()));
		СтруктураРезультата.Вставить("КоличествоСтрок", ТаблицаРезультата.Количество());
		СтруктураРезультата.Вставить("КоличествоКолонок", ТаблицаРезультата.Колонки.Количество());
		Возврат СтруктураРезультата;
	КонецЕсли;
КонецФункции

&НаСервере
Функция СтруктураХраненияКолонкиТаблицыНаФорме(ИмяКолонки)
	СтруктураХранения = УИ_ОбщегоНазначенияКлиентСервер.НовыйСтруктураХраненияРеквизитаНаФормеСКонейнером(ИмяКолонки);
	СтруктураХранения.ИмяПоляКонтейнера = ИмяВспомогательнойКолонкиТаблицы(ИмяКолонки,
																			  УИ_ОбщегоНазначенияКлиентСервер.СуффиксИмениПоляХраненияКонтейнераДляПоляСКонтейнером());
	СтруктураХранения.ИмяПоляТипаЗначения = ИмяВспомогательнойКолонкиТаблицы(ИмяКолонки,
																				УИ_ОбщегоНазначенияКлиентСервер.СуффиксИмениПоляХраненияТипаЗначенияДляПоляСКонтейнером());
	СтруктураХранения.ИмяПоляПредставленияТипаЗначения = ИмяВспомогательнойКолонкиТаблицы(ИмяКолонки,
																							 УИ_ОбщегоНазначенияКлиентСервер.СуффиксИмениПоляХраненияПредставленияТипаЗначенияДляПоляСКонтейнером());
	
	Возврат СтруктураХранения;
КонецФункции

// Заполнить уровень дерева формы по дереву источнику.
// 
// Параметры:
//  СтрокаДереваФорма -ДанныеФормыДерево, ДанныеФормыЭлементДерева - Строка дерева форма
//  СтрокаДереваИсточника -ДеревоЗначений, СтрокаДереваЗначений-Строка дерева источника
//  СтруктурыХраненияКолонокТаблицыНаФорме - Структура
&НаСервере
Процедура ЗаполнитьУровеньДереваФормыПоДеревуИсточнику(СтрокаДереваФорма, СтрокаДереваИсточника,
	СтруктурыХраненияКолонокТаблицыНаФорме)

	ЭлементыДереваФормы = СтрокаДереваФорма.ПолучитьЭлементы();

	Для Каждого Стр Из СтрокаДереваИсточника.Строки Цикл
		НС=ЭлементыДереваФормы.Добавить();

		Для Каждого СтрокаКолонки Из КолонкиТаблицы Цикл
			УИ_ОбщегоНазначенияКлиентСервер.УстановитьЗначениеПоляСКонтейнером(НС,
																			   СтруктурыХраненияКолонокТаблицыНаФорме[СтрокаКолонки.Имя],
																			   Стр[СтрокаКолонки.Имя]);
		КонецЦикла;

		ЗаполнитьУровеньДереваФормыПоДеревуИсточнику(НС, Стр, СтруктурыХраненияКолонокТаблицыНаФорме);
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьДеревоЗначенийФормыПоДереву(ДеревоИсточник)
	ДеревоЗначений = ЭтотОбъект[ИмяРеквизитаХранилища]; //ДанныеФормыДерево
	ДеревоЗначений.ПолучитьЭлементы().Очистить();

	СтруктурыХраненияКолонокТаблицыНаФорме = Новый Структура;

	Для Каждого СтрокаКолонки Из КолонкиТаблицы Цикл
		СтруктурыХраненияКолонокТаблицыНаФорме.Вставить(СтрокаКолонки.Имя,
														СтруктураХраненияКолонкиТаблицыНаФорме(СтрокаКолонки.Имя));
	КонецЦикла;

	ЗаполнитьУровеньДереваФормыПоДеревуИсточнику(ДеревоЗначений, ДеревоИсточник, СтруктурыХраненияКолонокТаблицыНаФорме);

КонецПроцедуры

&НаСервере
Процедура ДобавитьКорневойЭлементИРеквизитТаблицы()
	ИмяРеквизитаХранилища = "ТаблицаЗначений";
	МассивДобавляемыхРеквизитов = Новый Массив;
	
	Если ЭтоДерево Тогда
		ТипРеквизита = Новый ОписаниеТипов("ДеревоЗначений");
	Иначе
		ТипРеквизита = Новый ОписаниеТипов("ТаблицаЗначений");
	КонецЕсли;
	
	МассивДобавляемыхРеквизитов.Добавить(Новый РеквизитФормы(ИмяРеквизитаХранилища, ТипРеквизита, "", "", Истина));
	ИзменитьРеквизиты(МассивДобавляемыхРеквизитов);

	ОписаниеЭлемента=УИ_РаботаСФормами.НовыйОписаниеРеквизитаЭлемента();
	ОписаниеЭлемента.Вставить("Имя", ИмяРеквизитаХранилища);
	ОписаниеЭлемента.Вставить("ПутьКДанным", ИмяРеквизитаХранилища);
	ОписаниеЭлемента.Параметры.Тип = Тип("ТаблицаФормы");
	ОписаниеЭлемента.Параметры.Вставить("ПоложениеЗаголовка", ПоложениеЗаголовкаЭлементаФормы.Нет);
	Если ЭтоДерево Тогда
		ОписаниеЭлемента.Параметры.Вставить("Отображение", ОтображениеТаблицы.Дерево);
	КонецЕсли;

	ЭлементНовый = УИ_РаботаСФормами.СоздатьЭлементПоОписанию(ЭтотОбъект, ОписаниеЭлемента);
КонецПроцедуры

#КонецОбласти