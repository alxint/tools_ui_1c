#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ЗначениеХранилища = Неопределено;
	Если Параметры.Свойство("ХранилищеКонтейнераЗначения") Тогда
		//@skip-check unknown-form-parameter-access
		ХранилищеКонтейнера = Параметры.ХранилищеКонтейнераЗначения;//см. УИ_ОбщегоНазначенияКлиентСервер.НовыйХранилищеЗначенияТипаХранилищеЗначения
		Если ХранилищеКонтейнера <> Неопределено Тогда
			ХранилищеДляЗначения = УИ_ОбщегоНазначения.ЗначениеИзХранилищаКонтейнераХранилищаЗначения(ХранилищеКонтейнера); //ХранилищеЗначения
			//@skip-check empty-except-statement
			Попытка
				ЗначениеХранилища = ХранилищеДляЗначения.Получить();
			Исключение
			КонецПопытки;
		КонецЕсли;
	КонецЕсли;

	СтруктураХраненияПоля = УИ_ОбщегоНазначенияКлиентСервер.НовыйСтруктураХраненияРеквизитаНаФормеСКонейнером("Значение");

	УИ_ОбщегоНазначенияКлиентСервер.УстановитьЗначениеПоляСКонтейнером(ЭтотОбъект,
																	   СтруктураХраненияПоля,
																	   ЗначениеХранилища);
КонецПроцедуры



#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы


&НаКлиенте
Процедура ЗначениеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ПараметрыОбработчика = УИ_ОбщегоНазначенияКлиент.НовыйПараметрыОбработчикаСобытияНачалоВыбораЗначения(ЭтотОбъект,
																										  Элемент,
																										  "Значение");
	ПараметрыОбработчика.ДоступенКонтейнер = Истина;
	ПараметрыОбработчика.Значение = Значение;
	ПараметрыОбработчика.СтруктураХраненияЗначения = ЭтотОбъект;
	ПараметрыОбработчика.НаборТипов = УИ_ОбщегоНазначенияКлиентСервер.ВсеНаборыТиповДляРедактирования();

	УИ_ОбщегоНазначенияКлиент.ПолеФормыОбработчикНачалоВыбораЗначения(ПараметрыОбработчика, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура ЗначениеОчистка(Элемент, СтандартнаяОбработка)
	ПараметрыОбработчика = УИ_ОбщегоНазначенияКлиент.НовыйПараметрыОбработчикаСобытияОчистка(ЭтотОбъект,
																							 Элемент,
																							 "Значение");
	ПараметрыОбработчика.ДоступенКонтейнер = Истина;
	ПараметрыОбработчика.СтруктураХраненияЗначения = ЭтотОбъект;

	УИ_ОбщегоНазначенияКлиент.ПолеФормыОбработчикОчистка(ПараметрыОбработчика, СтандартнаяОбработка);

КонецПроцедуры


&НаКлиенте
Процедура ЗначениеПриИзменении(Элемент)
	ПараметрыОбработчика = УИ_ОбщегоНазначенияКлиент.НовыйПараметрыОбработчикаСобытияПриИзменении(ЭтотОбъект,
																								  Элемент,
																								  "Значение");
	ПараметрыОбработчика.ДоступенКонтейнер = Истина;
	ПараметрыОбработчика.СтруктураХраненияЗначения = ЭтотОбъект;

	УИ_ОбщегоНазначенияКлиент.ПолеФормыОбработчикПриИзменении(ПараметрыОбработчика);
КонецПроцедуры


#КонецОбласти

#Область ОбработчикиКомандФормы


&НаКлиенте
Процедура Применить(Команда)
	Закрыть(ХранилищеКонтейнераИзЗначенияФормы());
КонецПроцедуры
#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция ХранилищеКонтейнераИзЗначенияФормы()
	СтруктураХраненияПоля = УИ_ОбщегоНазначенияКлиентСервер.НовыйСтруктураХраненияРеквизитаНаФормеСКонейнером("Значение");
	Значение = УИ_ОбщегоНазначенияКлиентСервер.ЗначениеПоляСКонтейнеромЗначения(ЭтотОбъект, СтруктураХраненияПоля);
	
	Возврат УИ_ОбщегоНазначения.ЗначениеХранилищаКонтейнераХранилищаЗначенияИзПроизвользоногоЗначения(Значение);
КонецФункции

#КонецОбласти
