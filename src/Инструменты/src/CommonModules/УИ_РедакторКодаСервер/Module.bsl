#Область ПрограммныйИнтерфейс

#Область СозданиеЭлементовФормы

// Форма при создании на сервере.
// 
// Параметры:
//  Форма - ФормаКлиентскогоПриложения
//  ВидРедактора - Строка - Вид редактора, добавляемого на форму см. УИ_РедакторКодаКлиентСервер.ВариантыРедактораКода
Процедура ФормаПриСозданииНаСервере(Форма, ВидРедактора = Неопределено) Экспорт
	ВариантыРедактора = УИ_РедакторКодаКлиентСервер.ВариантыРедактораКода();

	Если ВидРедактора = Неопределено Тогда
		ПараметрыРедактора = ТекущиеПараметрыРедактораКода();
		ВидРедактора = ПараметрыРедактора.Вариант;
	КонецЕсли;

	ПараметрыФормированияРедакторов = ПараметрыФормированияРедакторов();
	Если Не ПараметрыФормированияРедакторов.ПолеHTMLПостроеноНаWebkit Тогда
		ВидРедактора = ВариантыРедактора.Текст;
	КонецЕсли;

	ИмяРеквизитаВидРедактора=УИ_РедакторКодаКлиентСервер.ИмяРеквизитаРедактораКодаВидРедактора();
	ИмяРеквизитаДанныеБиблиотекРедакторов=УИ_РедакторКодаКлиентСервер.ИмяРеквизитаРедактораКодаДанныеБиблиотекРедакторов();
	ИмяРеквизитаРедактораКодаСписокРедакторовФормы = УИ_РедакторКодаКлиентСервер.ИмяРеквизитаРедактораКодаСписокРедакторовФормы();
	ИмяРеквизитаРедактораКодаПервичнаяИнициализацияПрошла = УИ_РедакторКодаКлиентСервер.ИмяРеквизитаРедактораКодаПервичнаяИнициализацияПрошла();
	ИмяРеквизитаРедактораКодаПараметрыФормированияРедакторов = УИ_РедакторКодаКлиентСервер.ИмяРеквизитаРедактораКодаПараметрыФормированияРедакторов();

	МассивРеквизитов=Новый Массив;
	МассивРеквизитов.Добавить(Новый РеквизитФормы(ИмяРеквизитаВидРедактора, Новый ОписаниеТипов("Строка", ,
		Новый КвалификаторыСтроки(20, ДопустимаяДлина.Переменная)), "", "", Истина));
	МассивРеквизитов.Добавить(Новый РеквизитФормы(ИмяРеквизитаДанныеБиблиотекРедакторов, Новый ОписаниеТипов, "", "",
		Истина));
	МассивРеквизитов.Добавить(Новый РеквизитФормы(ИмяРеквизитаРедактораКодаСписокРедакторовФормы, Новый ОписаниеТипов,
		"", "", Истина));
	МассивРеквизитов.Добавить(Новый РеквизитФормы(ИмяРеквизитаРедактораКодаПервичнаяИнициализацияПрошла,
		Новый ОписаниеТипов("Булево"), "", "", Истина));
	МассивРеквизитов.Добавить(Новый РеквизитФормы(ИмяРеквизитаРедактораКодаПараметрыФормированияРедакторов,
		Новый ОписаниеТипов, "", "", Истина));

	Форма.ИзменитьРеквизиты(МассивРеквизитов);

	Форма[ИмяРеквизитаВидРедактора]=ВидРедактора;
	Форма[ИмяРеквизитаРедактораКодаСписокРедакторовФормы] = Новый Структура;
	Форма[ИмяРеквизитаДанныеБиблиотекРедакторов] = Новый Структура;
	Форма[ИмяРеквизитаРедактораКодаПараметрыФормированияРедакторов] = ПараметрыФормированияРедакторов;

	Форма[ИмяРеквизитаДанныеБиблиотекРедакторов].Вставить(ВидРедактора,
														  ДанныеБиблиотекиРедактора(Форма.УникальныйИдентификатор,
																					ПараметрыФормированияРедакторов,
																					ВидРедактора));
	
	ДобавитьДанныеБиблиотекиВзаимодействияВБиблиотекиРедакторовФормы(Форма, ВидРедактора);
	
КонецПроцедуры

// Создать элементы редактора кода.
// 
// Параметры:
//  Форма - ФормаКлиентскогоПриложения-
//  ИдентификаторРедактора - Строка - Уникальный в пределах формы идентификатор редактора. Должен соответствовать правилам именования переменных
//  ПолеРедактора - ПолеФормы - Поле редактора
//  СобытияРедактора - Неопределено, Структура - Имена процедур формы для обработки событий редактора. Список поддерживаемых событий в методе УИ_РедакторКодаКлиентСервер.НовыйПараметрыСобытийРедактора
//  ЯзыкРедактора - Строка - Язык редактора кода. По умолчанию "bsl". 
//  ГруппаКомманднойПанели - ГруппаФормы - Группа коммандной панели, куда будут добавлены кнопки. Пока в разработке
Процедура СоздатьЭлементыРедактораКода(Форма, ИдентификаторРедактора, ПолеРедактора, СобытияРедактора = Неопределено,
	ЯзыкРедактора = "bsl", ГруппаКомманднойПанели = Неопределено) Экспорт
	ВидРедактора = УИ_РедакторКодаКлиентСервер.ВидРедактораКодаФормы(Форма);

	ДанныеРедактора = УИ_РедакторКодаКлиентСервер.НовыйДанныеРедактораФормы();
	ДанныеРедактора.Идентификатор = ИдентификаторРедактора;
	ДанныеРедактора.СобытияРедактора= СобытияРедактора;
	Если ДанныеРедактора.СобытияРедактора = Неопределено Тогда
		ДанныеРедактора.СобытияРедактора = НовыйПараметрыСобытийРедактора();
	КонецЕсли;

	Если УИ_РедакторКодаКлиентСервер.РедакторКодаИспользуетПолеHTML(ВидРедактора) Тогда
		Если ПолеРедактора.Вид <> ВидПоляФормы.ПолеHTMLДокумента Тогда
			ПолеРедактора.Вид = ВидПоляФормы.ПолеHTMLДокумента;
		КонецЕсли;
		ПолеРедактора.УстановитьДействие("ДокументСформирован", "Подключаемый_ПолеРедактораДокументСформирован");
		ПолеРедактора.УстановитьДействие("ПриНажатии", "Подключаемый_ПолеРедактораПриНажатии");

	Иначе
		ПолеРедактора.Вид = ВидПоляФормы.ПолеТекстовогоДокумента;
		ДанныеРедактора.Инициализирован = Истина;
		
		Если ЗначениеЗаполнено(ДанныеРедактора.СобытияРедактора.ПриИзменении) Тогда
			ПолеРедактора.УстановитьДействие("ПриИзменении", ДанныеРедактора.СобытияРедактора.ПриИзменении);
		КонецЕсли;
	КонецЕсли;

	ДанныеРедактора.Язык = ЯзыкРедактора;
	ДанныеРедактора.ПолеРедактора= ПолеРедактора.Имя;
	ДанныеРедактора.ИмяРеквизита = ПолеРедактора.ПутьКДанным;

	ВариантыРедактора = УИ_РедакторКодаКлиентСервер.ВариантыРедактораКода();

	ПараметрыРедактора = ТекущиеПараметрыРедактораКода();
	ДанныеРедактора.ПараметрыРедактора = ПараметрыРедактора;
	
	Если ВидРедактора = ВариантыРедактора.Monaco Тогда
		Для Каждого КлючЗначение Из ПараметрыРедактора.Monaco Цикл
			ДанныеРедактора.ПараметрыРедактора.Вставить(КлючЗначение.Ключ, КлючЗначение.Значение);
		КонецЦикла;
	КонецЕсли;

	Форма[УИ_РедакторКодаКлиентСервер.ИмяРеквизитаРедактораКодаСписокРедакторовФормы()].Вставить(
		ИдентификаторРедактора, ДанныеРедактора);

	//Устанавливаем текст	
	ПараметрыФормированияРедакторов = УИ_РедакторКодаКлиентСервер.ПараметрыФормированияРедакторовФормы(Форма);
	Если ПараметрыФормированияРедакторов.ЭтоВебКлиент Тогда
		ДанныеБиблиотекРедакторов = УИ_РедакторКодаКлиентСервер.ДанныеБиблиотекРедакторов(Форма);
		Если ВидРедактора = ВариантыРедактора.Ace Тогда
			Форма[ДанныеРедактора.ИмяРеквизита] = ТекстПоляHTMLРедактораAce(ДанныеБиблиотекРедакторов[ВидРедактора]);
		ИначеЕсли ВидРедактора = ВариантыРедактора.Monaco Тогда
			Форма[ДанныеРедактора.ИмяРеквизита] = ТекстПоляHTMLРедактораMonaco(ДанныеБиблиотекРедакторов[ВидРедактора]);
		КонецЕсли;
	КонецЕсли;

	Если ГруппаКомманднойПанели = Неопределено Тогда
		Возврат;
	КонецЕсли;
	ДанныеРедактора.ИмяКоманднойПанелиРедактора = ГруппаКомманднойПанели.Имя;
	
	Если ЯзыкРедактора = "bsl" Тогда
		ОписаниеКнопки = УИ_РаботаСФормами.НовыйОписаниеКомандыКнопки();
		ОписаниеКнопки.Имя = УИ_РедакторКодаКлиентСервер.ИмяКнопкиКоманднойПанели(УИ_РедакторКодаКлиентСервер.ИмяКомандыРежимВыполненияЧерезОбработку(),
																				  ИдентификаторРедактора);
		ОписаниеКнопки.ИмяКоманды = ОписаниеКнопки.Имя;
		ОписаниеКнопки.Заголовок = "Через обработку";
		ОписаниеКнопки.РодительЭлемента = ГруппаКомманднойПанели;
		ОписаниеКнопки.Действие = "Подключаемый_ВыполнитьКомандуРедактораКода";
		ОписаниеКнопки.Картинка = БиблиотекаКартинок.Обработка;
		ОписаниеКнопки.Подсказка = "Режим выполнения кода через обработку. Позволяет использовать свои процедуры и функции";
		ОписаниеКнопки.Отображение = ОтображениеКнопки.Картинка;
		УИ_РаботаСФормами.СоздатьКомандуПоОписанию(Форма, ОписаниеКнопки);
		УИ_РаботаСФормами.СоздатьКнопкуПоОписанию(Форма, ОписаниеКнопки);
	КонецЕсли;
	
	ОписаниеПодменюИнтеграцииСPaste1C = УИ_РаботаСФормами.НовыйОписаниеГруппыФормы();
	ОписаниеПодменюИнтеграцииСPaste1C.Родитель = ГруппаКомманднойПанели;
	ОписаниеПодменюИнтеграцииСPaste1C.Вид = ВидГруппыФормы.Подменю;
	ОписаниеПодменюИнтеграцииСPaste1C.Имя = ГруппаКомманднойПанели.Имя +"_ПодменюИнтеграцииССервисомХраненияКода_"+ИдентификаторРедактора;
	ОписаниеПодменюИнтеграцииСPaste1C.ОтображатьЗаголовок = Ложь;
	ОписаниеПодменюИнтеграцииСPaste1C.Заголовок = "Paste 1C";

//	ОписаниеПодменюИнтеграцииСPaste1C.Отображение = ОтображениеОбычнойГруппы.Нет;
	Подменю = УИ_РаботаСФормами.СоздатьГруппуПоОписанию(Форма, ОписаниеПодменюИнтеграцииСPaste1C);
	Если Не УИ_ОбщегоНазначенияКлиентСервер.ЭтоПортативнаяПоставка() Тогда
		Подменю.Картинка = БиблиотекаКартинок.УИ_Поделиться;
	КонецЕсли;
	
	ОписаниеКнопки = УИ_РаботаСФормами.НовыйОписаниеКомандыКнопки();
	ОписаниеКнопки.Имя = УИ_РедакторКодаКлиентСервер.ИмяКнопкиКоманднойПанели(УИ_РедакторКодаКлиентСервер.ИмяКомандыПоделитьсяАлгоритмом(),
																			  ИдентификаторРедактора);
	ОписаниеКнопки.ИмяКоманды = ОписаниеКнопки.Имя;
	ОписаниеКнопки.Заголовок = "Поделиться алгоритмом";
	ОписаниеКнопки.РодительЭлемента = Подменю;
	ОписаниеКнопки.Действие = "Подключаемый_ВыполнитьКомандуРедактораКода";
	//ОписаниеКнопки.Картинка = БиблиотекаКартинок.Обработка;
	ОписаниеКнопки.Подсказка = "Поделиться кодом алгоритма";
	//ОписаниеКнопки.Отображение = ОтображениеКнопки.Картинка;
	УИ_РаботаСФормами.СоздатьКомандуПоОписанию(Форма, ОписаниеКнопки);
	УИ_РаботаСФормами.СоздатьКнопкуПоОписанию(Форма, ОписаниеКнопки);		
	
	ОписаниеКнопки = УИ_РаботаСФормами.НовыйОписаниеКомандыКнопки();
	ОписаниеКнопки.Имя = УИ_РедакторКодаКлиентСервер.ИмяКнопкиКоманднойПанели(УИ_РедакторКодаКлиентСервер.ИмяКомандыЗагрузитьАлгоритм(),
																			  ИдентификаторРедактора);
	ОписаниеКнопки.ИмяКоманды = ОписаниеКнопки.Имя;
	ОписаниеКнопки.Заголовок = "Загрузить алгоритм";
	ОписаниеКнопки.РодительЭлемента = Подменю;
	ОписаниеКнопки.Действие = "Подключаемый_ВыполнитьКомандуРедактораКода";
	//ОписаниеКнопки.Картинка = БиблиотекаКартинок.Обработка;
	ОписаниеКнопки.Подсказка = "Загрузить расшаренный код";
	//ОписаниеКнопки.Отображение = ОтображениеКнопки.Картинка;
	УИ_РаботаСФормами.СоздатьКомандуПоОписанию(Форма, ОписаниеКнопки);
	УИ_РаботаСФормами.СоздатьКнопкуПоОписанию(Форма, ОписаниеКнопки);		
	
	Если ВидРедактора = ВариантыРедактора.Ace Тогда
	// Взаимодействие
		ОписаниеПодменюСессииВзаимодействия = УИ_РаботаСФормами.НовыйОписаниеГруппыФормы();
		ОписаниеПодменюСессииВзаимодействия.Родитель = ГруппаКомманднойПанели;
		ОписаниеПодменюСессииВзаимодействия.Вид = ВидГруппыФормы.Подменю;
		ОписаниеПодменюСессииВзаимодействия.Имя = ГруппаКомманднойПанели.Имя
												  + "_ПодменюИнтеграцииССерверомКолаборации_"
												  + ИдентификаторРедактора;
		ОписаниеПодменюСессииВзаимодействия.ОтображатьЗаголовок = Ложь;
		ОписаниеПодменюСессииВзаимодействия.Заголовок = "";

//	ОписаниеПодменюИнтеграцииСPaste1C.Отображение = ОтображениеОбычнойГруппы.Нет;
		Подменю = УИ_РаботаСФормами.СоздатьГруппуПоОписанию(Форма, ОписаниеПодменюСессииВзаимодействия);
		Если Не УИ_ОбщегоНазначенияКлиентСервер.ЭтоПортативнаяПоставка() Тогда
			Подменю.Картинка = БиблиотекаКартинок.АктивныеПользователи;
		КонецЕсли;
		
		ОписаниеКнопки = УИ_РаботаСФормами.НовыйОписаниеКомандыКнопки();
		ОписаниеКнопки.Имя = УИ_РедакторКодаКлиентСервер.ИмяКнопкиКоманднойПанели(УИ_РедакторКодаКлиентСервер.ИмяКомандыНачатьСессиюВзаимодействия(),
																				  ИдентификаторРедактора);
		ОписаниеКнопки.ИмяКоманды = ОписаниеКнопки.Имя;
		ОписаниеКнопки.Заголовок = "Начать сессию взаимодейтсвия";
		ОписаниеКнопки.РодительЭлемента = Подменю;
		ОписаниеКнопки.Действие = "Подключаемый_ВыполнитьКомандуРедактораКода";
	//ОписаниеКнопки.Картинка = БиблиотекаКартинок.Обработка;
		ОписаниеКнопки.Подсказка = "Начать сессию совместного кодинга";
	//ОписаниеКнопки.Отображение = ОтображениеКнопки.Картинка;
		УИ_РаботаСФормами.СоздатьКомандуПоОписанию(Форма, ОписаниеКнопки);
		УИ_РаботаСФормами.СоздатьКнопкуПоОписанию(Форма, ОписаниеКнопки);

		ОписаниеКнопки = УИ_РаботаСФормами.НовыйОписаниеКомандыКнопки();
		ОписаниеКнопки.Имя = УИ_РедакторКодаКлиентСервер.ИмяКнопкиКоманднойПанели(УИ_РедакторКодаКлиентСервер.ИмяКомандыЗакончитьСессиюВзаимодействия(),
																				  ИдентификаторРедактора);
		ОписаниеКнопки.ИмяКоманды = ОписаниеКнопки.Имя;
		ОписаниеКнопки.Заголовок = "Завершить сессию взаимодейтсвия";
		ОписаниеКнопки.РодительЭлемента = Подменю;
		ОписаниеКнопки.Действие = "Подключаемый_ВыполнитьКомандуРедактораКода";
	//ОписаниеКнопки.Картинка = БиблиотекаКартинок.Обработка;
		ОписаниеКнопки.Подсказка = "Завершить сессию совместного кодинга";
	//ОписаниеКнопки.Отображение = ОтображениеКнопки.Картинка;
		УИ_РаботаСФормами.СоздатьКомандуПоОписанию(Форма, ОписаниеКнопки);
		УИ_РаботаСФормами.СоздатьКнопкуПоОписанию(Форма, ОписаниеКнопки);

	КонецЕсли;
	
	
//
//
//		
//	ОписаниеКнопки = УИ_РаботаСФормами.НовыйОписаниеКомандыКнопки();
//	ОписаниеКнопки.Имя = УИ_РедакторКодаКлиентСервер.ИмяКнопкиКоманднойПанели(УИ_РедакторКодаКлиентСервер.ИмяКомандыКонструкторЗапроса(),
//																			  ИдентификаторРедактора);
//	ОписаниеКнопки.ИмяКоманды = ОписаниеКнопки.Имя;
//	ОписаниеКнопки.Заголовок = "Конструктор запроса";
//	ОписаниеКнопки.РодительЭлемента = ГруппаКомманднойПанели;
//	ОписаниеКнопки.Действие = "Подключаемый_ВыполнитьКомандуРедактораКода";
//	ОписаниеКнопки.Картинка = БиблиотекаКартинок.КонструкторЗапроса;
//	ОписаниеКнопки.Отображение = ОтображениеКнопки.Картинка;
//	УИ_РаботаСФормами.СоздатьКомандуПоОписанию(Форма, ОписаниеКнопки);
//	УИ_РаботаСФормами.СоздатьКнопкуПоОписанию(Форма, ОписаниеКнопки);	
		
	//Кнопки
//	1 - Конструктор запроса
//2 - конструктор форматной строки
//3 - Редактор запроса
//4 - форматировать текст
//6- Проверить синтаксис
//7 - Выполнить
//8 - Добавить комментарий
//9 - Удалить комментарий
//10 - Добавить закладку
//11 - Удалить закладку
//12 - Следующая закладка
//13 - Добавить перенос строки
//14 - Удалить перенос строки
//15 - Переход к строке
//16 - Вставить предопределенное значение
//17 - Добавить макроколонку
//18 - Сохранить как обработку

КонецПроцедуры

// Новый параметры событий редактора.
// 
// Возвращаемое значение:
//  Структура - Новый параметры событий редактора:
// * ПриИзменении - Строка -
Функция НовыйПараметрыСобытийРедактора() Экспорт
	Возврат УИ_РедакторКодаКлиентСервер.НовыйПараметрыСобытийРедактора();
КонецФункции

#КонецОбласти

#Область НастройкиИнструментов
Функция ТекущийВариантРедактораКода1С() Экспорт
	ПараметрыРедактораКода = ТекущиеПараметрыРедактораКода();

	РедакторКода = ПараметрыРедактораКода.Вариант;

	УИ_ПараметрыСеанса = УИ_ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
		УИ_ОбщегоНазначенияКлиентСервер.КлючОбъектаВХранилищеНастроек(),
		УИ_ОбщегоНазначенияКлиентСервер.КлючНастроекПараметровСеанса());

	Если Тип(УИ_ПараметрыСеанса) = Тип("Структура") Тогда
		Если УИ_ПараметрыСеанса.ПолеHTMLПостроеноНаWebkit <> Истина Тогда
			РедакторКода = УИ_РедакторКодаКлиентСервер.ВариантыРедактораКода().Текст;
		КонецЕсли;
	КонецЕсли;

	Возврат РедакторКода;
КонецФункции

Процедура УстановитьНовыеНастройкиРедактораКода(НовыеНастройки) Экспорт
	УИ_ОбщегоНазначения.ХранилищеОбщихНастроекСохранить(
		УИ_ОбщегоНазначенияКлиентСервер.КлючДанныхНастроекВХранилищеНастроек(), "ПараметрыРедактораКода",
		НовыеНастройки);
КонецПроцедуры

Функция ТекущиеПараметрыРедактораКода() Экспорт
	СохраненныеПараметрыРедактора = УИ_ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
		УИ_ОбщегоНазначенияКлиентСервер.КлючДанныхНастроекВХранилищеНастроек(), "ПараметрыРедактораКода");

	ПараметрыПоУмолчанию = УИ_РедакторКодаКлиентСервер.ПараметрыРедактораКодаПоУмолчанию();
	Если СохраненныеПараметрыРедактора = Неопределено Тогда
		ПараметрыПоУмолчанию.Вариант = УИ_РедакторКодаКлиентСервер.ВариантРедактораПоУмолчанию();
		ПараметрыРедактораMonaco = ТекущиеПараметрыРедактораMonaco();

		ЗаполнитьЗначенияСвойств(ПараметрыПоУмолчанию.Monaco, ПараметрыРедактораMonaco);
	Иначе
		ЗаполнитьЗначенияСвойств(ПараметрыПоУмолчанию, СохраненныеПараметрыРедактора, , "Monaco");
		ЗаполнитьЗначенияСвойств(ПараметрыПоУмолчанию.Monaco, СохраненныеПараметрыРедактора.Monaco);
	КонецЕсли;

	Возврат ПараметрыПоУмолчанию;

КонецФункции

#КонецОбласти

#Область Метаданные

Функция ЯзыкСинтаксисаКонфигурации() Экспорт
	Если Метаданные.ВариантВстроенногоЯзыка = Метаданные.СвойстваОбъектов.ВариантВстроенногоЯзыка.Английский Тогда
		Возврат "Английский";
	Иначе
		Возврат "Русский";
	КонецЕсли;
КонецФункции

Функция ОбъектМетаданныхИмеетПредопределенные(ИмяТипаМетаданного)

	Объекты = Новый Массив;
	Объекты.Добавить("справочник");
	Объекты.Добавить("справочники");
	Объекты.Добавить("плансчетов");
	Объекты.Добавить("планысчетов");
	Объекты.Добавить("планвидовхарактеристик");
	Объекты.Добавить("планывидовхарактеристик");
	Объекты.Добавить("планвидоврасчета");
	Объекты.Добавить("планывидоврасчета");

	Возврат Объекты.Найти(НРег(ИмяТипаМетаданного)) <> Неопределено;

КонецФункции

Функция ОбъектМетаданныхИмеетВиртуальныеТаблицы(ИмяТипаМетаданного)

	Объекты = Новый Массив;
	Объекты.Добавить("РегистрыСведений");
	Объекты.Добавить("РегистрыНакопления");
	Объекты.Добавить("РегистрыРасчета");
	Объекты.Добавить("РегистрыБухгалтерии");

	Возврат Объекты.Найти(ИмяТипаМетаданного) <> Неопределено;

КонецФункции

Функция ОписаниеРеквизитаОбъектаМетаданных(Реквизит, ТипВсеСсылки)
	Описание = Новый Структура;
	Описание.Вставить("Имя", Реквизит.Имя);
	Описание.Вставить("Синоним", Реквизит.Синоним);
	Описание.Вставить("Комментарий", Реквизит.Комментарий);

	СсылочныеТипы = Новый Массив;
	Для Каждого ТекТ Из Реквизит.Тип.Типы() Цикл
		Если ТипВсеСсылки.СодержитТип(ТекТ) Тогда
			СсылочныеТипы.Добавить(ТекТ);
		КонецЕсли;
	КонецЦикла;
	Описание.Вставить("Тип", Новый ОписаниеТипов(СсылочныеТипы));

	Возврат Описание;
КонецФункции

Функция ОписаниеОбъектаМетаданныхКонфигурацииПоИмени(ВидОбъекта, ИмяОбъекта) Экспорт
	ТипВсеСсылки = УИ_ОбщегоНазначения.ОписаниеТипаВсеСсылки();

	Возврат ОписаниеОбъектаМетаданныхКонфигурации(Метаданные[ВидОбъекта][ИмяОбъекта], ВидОбъекта, ТипВсеСсылки);
КонецФункции

Функция ОписаниеОбъектаМетаданныхКонфигурации(ОбъектМетаданных, ВидОбъекта, ТипВсеСсылки,
	ВключатьОписаниеРеквизитов = Истина) Экспорт
	ОписаниеЭлемента = Новый Структура;
	ОписаниеЭлемента.Вставить("ВидОбъекта", ВидОбъекта);
	ОписаниеЭлемента.Вставить("Имя", ОбъектМетаданных.Имя);
	ОписаниеЭлемента.Вставить("Синоним", ОбъектМетаданных.Синоним);
	ОписаниеЭлемента.Вставить("Комментарий", ОбъектМетаданных.Комментарий);

	Расширение = ОбъектМетаданных.РасширениеКонфигурации();
	Если Расширение <> Неопределено Тогда
		ОписаниеЭлемента.Вставить("Расширение", Расширение.Имя);
	Иначе
		ОписаниеЭлемента.Вставить("Расширение", Неопределено);
	КонецЕсли;
	Если НРег(ВидОбъекта) = "константа" Или НРег(ВидОбъекта) = "константы" Тогда
		ОписаниеЭлемента.Вставить("Тип", ОбъектМетаданных.Тип);
	ИначеЕсли НРег(ВидОбъекта) = "перечисление" Или НРег(ВидОбъекта) = "перечисления" Тогда
		ЗначенияПеречисления = Новый Структура;

		Для Каждого ТекЗнч Из ОбъектМетаданных.ЗначенияПеречисления Цикл
			ЗначенияПеречисления.Вставить(ТекЗнч.Имя, ТекЗнч.Синоним);
		КонецЦикла;

		ОписаниеЭлемента.Вставить("ЗначенияПеречисления", ЗначенияПеречисления);
	КонецЕсли;

	Если Не ВключатьОписаниеРеквизитов Тогда
		Возврат ОписаниеЭлемента;
	КонецЕсли;

	КоллекцииРеквизитов = Новый Структура("Реквизиты, СтандартныеРеквизиты, Измерения, Ресурсы, РеквизитыАдресации, ПризнакиУчета");
	КоллекцииТЧ = Новый Структура("ТабличныеЧасти, СтандартныеТабличныеЧасти");
	ЗаполнитьЗначенияСвойств(КоллекцииРеквизитов, ОбъектМетаданных);
	ЗаполнитьЗначенияСвойств(КоллекцииТЧ, ОбъектМетаданных);

	Для Каждого КлючЗначение Из КоллекцииРеквизитов Цикл
		Если КлючЗначение.Значение = Неопределено Тогда
			Продолжить;
		КонецЕсли;

		ОписаниеКоллекцииРеквизитов= Новый Структура;

		Для Каждого ТекРеквизит Из КлючЗначение.Значение Цикл
			ОписаниеКоллекцииРеквизитов.Вставить(ТекРеквизит.Имя, ОписаниеРеквизитаОбъектаМетаданных(ТекРеквизит,
				ТипВсеСсылки));
		КонецЦикла;

		ОписаниеЭлемента.Вставить(КлючЗначение.Ключ, ОписаниеКоллекцииРеквизитов);
	КонецЦикла;

	Для Каждого КлючЗначение Из КоллекцииТЧ Цикл
		Если КлючЗначение.Значение = Неопределено Тогда
			Продолжить;
		КонецЕсли;

		ОписаниеКоллекцииТЧ = Новый Структура;

		Для Каждого ТЧ Из КлючЗначение.Значение Цикл
			ОписаниеТЧ = Новый Структура;
			ОписаниеТЧ.Вставить("Имя", ТЧ.Имя);
			ОписаниеТЧ.Вставить("Синоним", ТЧ.Синоним);
			ОписаниеТЧ.Вставить("Комментарий", ТЧ.Комментарий);

			КоллекцииРеквизитовТЧ = Новый Структура("Реквизиты, СтандартныеРеквизиты");
			ЗаполнитьЗначенияСвойств(КоллекцииРеквизитовТЧ, ТЧ);
			Для Каждого ТекКоллекцияРеквизитовТЧ Из КоллекцииРеквизитовТЧ Цикл
				Если ТекКоллекцияРеквизитовТЧ.Значение = Неопределено Тогда
					Продолжить;
				КонецЕсли;

				ОписаниеКоллекцииРеквизитовТЧ = Новый Структура;

				Для Каждого ТекРеквизит Из ТекКоллекцияРеквизитовТЧ.Значение Цикл
					ОписаниеКоллекцииРеквизитовТЧ.Вставить(ТекРеквизит.Имя, ОписаниеРеквизитаОбъектаМетаданных(
						ТекРеквизит, ТипВсеСсылки));
				КонецЦикла;

				ОписаниеТЧ.Вставить(ТекКоллекцияРеквизитовТЧ.Ключ, ОписаниеКоллекцииРеквизитовТЧ);
			КонецЦикла;
			ОписаниеКоллекцииТЧ.Вставить(ТЧ.Имя, ОписаниеТЧ);
		КонецЦикла;

		ОписаниеЭлемента.Вставить(КлючЗначение.Ключ, ОписаниеКоллекцииТЧ);
	КонецЦикла;
	Если ОбъектМетаданныхИмеетПредопределенные(ВидОбъекта) Тогда

		Предопределенные = ОбъектМетаданных.ПолучитьИменаПредопределенных();

		ОписаниеПредопределенных = Новый Структура;
		Для Каждого Имя Из Предопределенные Цикл
			ОписаниеПредопределенных.Вставить(Имя, "");
		КонецЦикла;

		ОписаниеЭлемента.Вставить("Предопределенные", ОписаниеПредопределенных);
	КонецЕсли;

	Возврат ОписаниеЭлемента;
КонецФункции

Функция ОписаниеКоллекцииМетаданныхКонфигурации(Коллекция, ВидОбъекта, СоответствиеТипов, ТипВсеСсылки,
	ВключатьОписаниеРеквизитов)
	ОписаниеКоллекции = Новый Структура;

	Для Каждого ОбъектМетаданных Из Коллекция Цикл
		ОписаниеЭлемента = ОписаниеОбъектаМетаданныхКонфигурации(ОбъектМетаданных, ВидОбъекта, ТипВсеСсылки,
			ВключатьОписаниеРеквизитов);

		ОписаниеКоллекции.Вставить(ОбъектМетаданных.Имя, ОписаниеЭлемента);

		Если УИ_ОбщегоНазначения.ЭтоОбъектСсылочногоТипа(ОбъектМетаданных) Тогда
			СоответствиеТипов.Вставить(Тип(ВидОбъекта + "Ссылка." + ОписаниеЭлемента.Имя), ОписаниеЭлемента);
		КонецЕсли;

	КонецЦикла;

	Возврат ОписаниеКоллекции;
КонецФункции

Функция ОписаниеОбщихМодулейКонфигурации() Экспорт
	ОписаниеКоллекции = Новый Структура;

	Для Каждого ОбъектМетаданных Из Метаданные.ОбщиеМодули Цикл

		ОписаниеКоллекции.Вставить(ОбъектМетаданных.Имя, Новый Структура);

	КонецЦикла;

	Возврат ОписаниеКоллекции;
КонецФункции

Функция ОписнаиеМетаданныйДляИнициализацииРедактораMonaco() Экспорт
	СоответствиеТипов = Новый Соответствие;
	ТипВсеСсылки = УИ_ОбщегоНазначения.ОписаниеТипаВсеСсылки();

	ОписаниеМетаданных = Новый Структура;
	ОписаниеМетаданных.Вставить("ОбщиеМодули", ОписаниеОбщихМодулейКонфигурации());
//	ОписаниеМетаданных.Вставить("Роли", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.Роли, "Роль", СоответствиеТипов, ТипВсеСсылки));
//	ОписаниеМетаданных.Вставить("ОбщиеФормы", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.ОбщиеФормы, "ОбщаяФорма", СоответствиеТипов, ТипВсеСсылки));

	Возврат ОписаниеМетаданных;
КонецФункции

Функция ОписаниеМетаданныхКонфигурации(ВключатьОписаниеРеквизитов = Истина) Экспорт
	ТипВсеСсылки = УИ_ОбщегоНазначения.ОписаниеТипаВсеСсылки();

	ОписаниеМетаданных = Новый Структура;

	СоответствиеТипов = Новый Соответствие;

	ОписаниеМетаданных.Вставить("Имя", Метаданные.Имя);
	ОписаниеМетаданных.Вставить("Версия", Метаданные.Версия);
	ОписаниеМетаданных.Вставить("ТипВсеСсылки", ТипВсеСсылки);

	ОписаниеМетаданных.Вставить("Справочники", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.Справочники,
		"Справочник", СоответствиеТипов, ТипВсеСсылки, ВключатьОписаниеРеквизитов));
	ОписаниеМетаданных.Вставить("Документы", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.Документы, "Документ",
		СоответствиеТипов, ТипВсеСсылки, ВключатьОписаниеРеквизитов));
	ОписаниеМетаданных.Вставить("РегистрыСведений", ОписаниеКоллекцииМетаданныхКонфигурации(
		Метаданные.РегистрыСведений, "РегистрСведений", СоответствиеТипов, ТипВсеСсылки, ВключатьОписаниеРеквизитов));
	ОписаниеМетаданных.Вставить("РегистрыНакопления", ОписаниеКоллекцииМетаданныхКонфигурации(
		Метаданные.РегистрыНакопления, "РегистрНакопления", СоответствиеТипов, ТипВсеСсылки,
		ВключатьОписаниеРеквизитов));
	ОписаниеМетаданных.Вставить("РегистрыБухгалтерии", ОписаниеКоллекцииМетаданныхКонфигурации(
		Метаданные.РегистрыБухгалтерии, "РегистрБухгалтерии", СоответствиеТипов, ТипВсеСсылки,
		ВключатьОписаниеРеквизитов));
	ОписаниеМетаданных.Вставить("РегистрыРасчета", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.РегистрыРасчета,
		"РегистрРасчета", СоответствиеТипов, ТипВсеСсылки, ВключатьОписаниеРеквизитов));
	ОписаниеМетаданных.Вставить("Обработки", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.Обработки, "Обработка",
		СоответствиеТипов, ТипВсеСсылки, ВключатьОписаниеРеквизитов));
	ОписаниеМетаданных.Вставить("Отчеты", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.Отчеты, "Отчет",
		СоответствиеТипов, ТипВсеСсылки, ВключатьОписаниеРеквизитов));
	ОписаниеМетаданных.Вставить("Перечисления", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.Перечисления,
		"Перечисление", СоответствиеТипов, ТипВсеСсылки, ВключатьОписаниеРеквизитов));
	ОписаниеМетаданных.Вставить("ОбщиеМодули", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.ОбщиеМодули,
		"ОбщийМодуль", СоответствиеТипов, ТипВсеСсылки, ВключатьОписаниеРеквизитов));
	ОписаниеМетаданных.Вставить("ПланыСчетов", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.ПланыСчетов,
		"ПланСчетов", СоответствиеТипов, ТипВсеСсылки, ВключатьОписаниеРеквизитов));
	ОписаниеМетаданных.Вставить("БизнесПроцессы", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.БизнесПроцессы,
		"БизнесПроцесс", СоответствиеТипов, ТипВсеСсылки, ВключатьОписаниеРеквизитов));
	ОписаниеМетаданных.Вставить("Задачи", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.Задачи, "Задача",
		СоответствиеТипов, ТипВсеСсылки, ВключатьОписаниеРеквизитов));
	ОписаниеМетаданных.Вставить("ПланыСчетов", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.ПланыСчетов,
		"ПланСчетов", СоответствиеТипов, ТипВсеСсылки, ВключатьОписаниеРеквизитов));
	ОписаниеМетаданных.Вставить("ПланыОбмена", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.ПланыОбмена,
		"ПланОбмена", СоответствиеТипов, ТипВсеСсылки, ВключатьОписаниеРеквизитов));
	ОписаниеМетаданных.Вставить("ПланыВидовХарактеристик", ОписаниеКоллекцииМетаданныхКонфигурации(
		Метаданные.ПланыВидовХарактеристик, "ПланВидовХарактеристик", СоответствиеТипов, ТипВсеСсылки,
		ВключатьОписаниеРеквизитов));
	ОписаниеМетаданных.Вставить("ПланыВидовРасчета", ОписаниеКоллекцииМетаданныхКонфигурации(
		Метаданные.ПланыВидовРасчета, "ПланВидовРасчета", СоответствиеТипов, ТипВсеСсылки, ВключатьОписаниеРеквизитов));
	ОписаниеМетаданных.Вставить("Константы", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.Константы, "Константа",
		СоответствиеТипов, ТипВсеСсылки, ВключатьОписаниеРеквизитов));
	ОписаниеМетаданных.Вставить("ПараметрыСеанса", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.ПараметрыСеанса,
		"ПараметрСеанса", СоответствиеТипов, ТипВсеСсылки, ВключатьОписаниеРеквизитов));

	ОписаниеМетаданных.Вставить("СоответствиеСсылочныхТипов", СоответствиеТипов);

	Возврат ОписаниеМетаданных;
КонецФункции

Функция АдресОписанияМетаданныхКонфигурации() Экспорт
	ОПисание = ОписаниеМетаданныхКонфигурации();

	Возврат ПоместитьВоВременноеХранилище(ОПисание, Новый УникальныйИдентификатор);
КонецФункции

Функция СписокМетаданныхПоВиду(ВидМетаданных) Экспорт
	КоллекцияМетаданных = Метаданные[ВидМетаданных];

	МассивИмен = Новый Массив;
	Для Каждого ОбъектМетаданных Из КоллекцияМетаданных Цикл
		МассивИмен.Добавить(ОбъектМетаданных.Имя);
	КонецЦикла;

	Возврат МассивИмен;
КонецФункции

Процедура ДобавитьКоллекциюМетаданныхВСоответствиеСсылочныхТипов(СоответствиеТипов, Коллекция, ВидОбъекта)
	Для Каждого ОбъектМетаданных Из Коллекция Цикл
		ОписаниеЭлемента = Новый Структура;
		ОписаниеЭлемента.Вставить("Имя", ОбъектМетаданных.Имя);
		ОписаниеЭлемента.Вставить("ВидОбъекта", ВидОбъекта);

		СоответствиеТипов.Вставить(Тип(ВидОбъекта + "Ссылка." + ОбъектМетаданных.Имя), ОписаниеЭлемента);
	КонецЦикла;

КонецПроцедуры

Функция СоответствиеСсылочныхТипов() Экспорт
	Соответствие = Новый Соответствие;
	ДобавитьКоллекциюМетаданныхВСоответствиеСсылочныхТипов(Соответствие, Метаданные.Справочники, "Справочник");
	ДобавитьКоллекциюМетаданныхВСоответствиеСсылочныхТипов(Соответствие, Метаданные.Документы, "Документ");
	ДобавитьКоллекциюМетаданныхВСоответствиеСсылочныхТипов(Соответствие, Метаданные.Перечисления, "Перечисление");
	ДобавитьКоллекциюМетаданныхВСоответствиеСсылочныхТипов(Соответствие, Метаданные.ПланыСчетов, "ПланСчетов");
	ДобавитьКоллекциюМетаданныхВСоответствиеСсылочныхТипов(Соответствие, Метаданные.БизнесПроцессы, "БизнесПроцесс");
	ДобавитьКоллекциюМетаданныхВСоответствиеСсылочныхТипов(Соответствие, Метаданные.Задачи, "Задача");
	ДобавитьКоллекциюМетаданныхВСоответствиеСсылочныхТипов(Соответствие, Метаданные.ПланыСчетов, "ПланСчетов");
	ДобавитьКоллекциюМетаданныхВСоответствиеСсылочныхТипов(Соответствие, Метаданные.ПланыОбмена, "ПланОбмена");
	ДобавитьКоллекциюМетаданныхВСоответствиеСсылочныхТипов(Соответствие, Метаданные.ПланыВидовХарактеристик,
		"ПланВидовХарактеристик");
	ДобавитьКоллекциюМетаданныхВСоответствиеСсылочныхТипов(Соответствие, Метаданные.ПланыВидовРасчета,
		"ПланВидовРасчета");

	Возврат Соответствие;
КонецФункции

#КонецОбласти

// Редакторы для сборки с преобразованным текстом модуля.
// 
// Параметры:
//  РедакторыДляСборки - Массив из см. УИ_РедакторКодаКлиентСервер.НовыйДанныеРедактораДляСборкиОбработки - Редакторы для сборки
// 
// Возвращаемое значение:
// Массив из см. УИ_РедакторКодаКлиентСервер.НовыйДанныеРедактораДляСборкиОбработки 
Функция РедакторыДляСборкиСПреобразованнымТекстомМодуля(РедакторыДляСборки) Экспорт
	Для Каждого ТекРедактор Из РедакторыДляСборки Цикл
		ТекРедактор.ТекстРедактораДляОбработки = УИ_РаботаСКодом.ТекстМодуляОбработкиИсполненияАлгоритма(ТекРедактор.ТекстРедактора,
																										 ТекРедактор.ИменаПредустановленныхПеременных,
																										 ТекРедактор.ИсполнениеНаКлиенте);
	КонецЦикла;
	Возврат РедакторыДляСборки;
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Функция ТекущиеПараметрыРедактораMonaco() Экспорт
	ПараметрыИзХранилища =  УИ_ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
		УИ_ОбщегоНазначенияКлиентСервер.КлючДанныхНастроекВХранилищеНастроек(), "ПараметрыРедактораMonaco",
		УИ_РедакторКодаКлиентСервер.ПараметрыРедактораMonacoПоУмолчанию());

	ПараметрыПоУмолчанию = УИ_РедакторКодаКлиентСервер.ПараметрыРедактораMonacoПоУмолчанию();
	ЗаполнитьЗначенияСвойств(ПараметрыПоУмолчанию, ПараметрыИзХранилища);

	Возврат ПараметрыПоУмолчанию;
КонецФункции

Функция ДоступныеИсточникиИсходногоКода() Экспорт
	Массив = Новый СписокЗначений;

	Массив.Добавить("ОсновнаяКонфигурация", "Основная конфигурация");

	МассивРасширений = РасширенияКонфигурации.Получить();
	Для Каждого ТекРасширение Из МассивРасширений Цикл
		Массив.Добавить(ТекРасширение.Имя, ТекРасширение.Синоним);
	КонецЦикла;

	Возврат Массив;
КонецФункции


// Данные библиотеки общего макета.
// 
// Параметры:
//  ИмяМакета - Строка -Имя макета
//  ИдентификаторФормы - УникальныйИдентификатор
//  ДляИзвлеченияНаКлиенте - Булево
// 
// Возвращаемое значение:
//  см. УИ_РедакторКодаКлиентСервер.НовыйДанныеБиблиотекиРедактора
Функция ДанныеБиблиотекиОбщегоМакета(ИмяМакета, ИдентификаторФормы, ДляИзвлеченияНаКлиенте) Экспорт

	ДанныеБиблиотеки = УИ_РедакторКодаКлиентСервер.НовыйДанныеБиблиотекиРедактора();
	ДанныеБиблиотеки.ИмяМакета = ИмяМакета;

	ДвоичныеДанныеБиблиотеки=ПолучитьОбщийМакет(ИмяМакета);

	Если ДляИзвлеченияНаКлиенте Тогда
		ДанныеБиблиотеки.ДанныеФайлов.Вставить("data.zip", ДвоичныеДанныеБиблиотеки);
		Возврат ДанныеБиблиотеки;
	КонецЕсли;

	КаталогНаСервере=ПолучитьИмяВременногоФайла();
	СоздатьКаталог(КаталогНаСервере);

	Поток=ДвоичныеДанныеБиблиотеки.ОткрытьПотокДляЧтения();

	ЧтениеZIP=Новый ЧтениеZipФайла(Поток);
	ЧтениеZIP.ИзвлечьВсе(КаталогНаСервере, РежимВосстановленияПутейФайловZIP.Восстанавливать);
	
	ДлинаИмениКаталога = СтрДлина(КаталогНаСервере);
	Если Прав(КаталогНаСервере, 1)<>ПолучитьРазделительПути() Тогда
		ДлинаИмениКаталога = ДлинаИмениКаталога + 1;
	КонецЕсли;

	ФайлыАрхива=НайтиФайлы(КаталогНаСервере, ПолучитьМаскуВсеФайлы(), Истина);
	Для Каждого ФайлБиблиотеки Из ФайлыАрхива Цикл
		Если ФайлБиблиотеки.ЭтоКаталог() Тогда
			Продолжить;
		КонецЕсли;

		ДвоичныеДанныеФайла = Новый ДвоичныеДанные(ФайлБиблиотеки.ПолноеИмя);
		АдресДанныхВХранилище = ПоместитьВоВременноеХранилище(ДвоичныеДанныеФайла, ИдентификаторФормы);

		ДанныеБиблиотеки.ДанныеФайлов.Вставить(Сред(ФайлБиблиотеки.ПолноеИмя, ДлинаИмениКаталога+1),
											   АдресДанныхВХранилище);
		Если НРег(ФайлБиблиотеки.Расширение) = ".js" Тогда
			ДанныеБиблиотеки.Скрипты.Добавить(АдресДанныхВХранилище);
		ИначеЕсли НРег(ФайлБиблиотеки.Расширение) = ".css" Тогда
			ДанныеБиблиотеки.Стили.Добавить(ТекстИзДвоичныхДанных(ДвоичныеДанныеФайла));
		КонецЕсли;
																						  
	КонецЦикла;

	//@skip-check empty-except-statement
	Попытка
		УдалитьФайлы(КаталогНаСервере);
	Исключение
	КонецПопытки;

	Возврат ДанныеБиблиотеки;	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Параметры формирования редакторов.
// 
// Возвращаемое значение:
//  см. УИ_РедакторКодаКлиентСервер.НовыйПараметрыФормированияРедакторов
Функция ПараметрыФормированияРедакторов() 
	ПарамерыФормирования = УИ_РедакторКодаКлиентСервер.НовыйПараметрыФормированияРедакторов();
	
	ПараметрыСеансаВХранилище = УИ_ОбщегоНазначенияВызовСервера.ХранилищеОбщихНастроекЗагрузить(
		УИ_ОбщегоНазначенияКлиентСервер.КлючОбъектаВХранилищеНастроек(),
		УИ_ОбщегоНазначенияКлиентСервер.КлючНастроекПараметровСеанса());
	Если Тип(ПараметрыСеансаВХранилище) = Тип("Структура") Тогда
		Если ПараметрыСеансаВХранилище.Свойство("ПолеHTMLПостроеноНаWebkit") Тогда
			ПарамерыФормирования.ПолеHTMLПостроеноНаWebkit = ПараметрыСеансаВХранилище.ПолеHTMLПостроеноНаWebkit;
		КонецЕсли;
		Если ПараметрыСеансаВХранилище.Свойство("ЭтоWindowsКлиент") Тогда
			ПарамерыФормирования.ЭтоWindowsКлиент = ПараметрыСеансаВХранилище.ЭтоWindowsКлиент;
		КонецЕсли;
		Если ПараметрыСеансаВХранилище.Свойство("ЭтоВебКлиент") Тогда
			ПарамерыФормирования.ЭтоВебКлиент = ПараметрыСеансаВХранилище.ЭтоВебКлиент;
		КонецЕсли;

	КонецЕсли;
	
	Возврат ПарамерыФормирования;
КонецФункции

// Добавить данные библиотеки взаимодействия в библиотеки редакторов формы.
// 
// Параметры:
//  Форма - ФормаКлиентскогоПриложения -
//  ВидРедактора -Строка -Вид редактора
Процедура ДобавитьДанныеБиблиотекиВзаимодействияВБиблиотекиРедакторовФормы(Форма, ВидРедактора)
//	ИмяРеквизитаДанныеБиблиотекРедакторов=УИ_РедакторКодаКлиентСервер.ИмяРеквизитаРедактораКодаДанныеБиблиотекРедакторов();
//	ВариантыРедактора = УИ_РедакторКодаКлиентСервер.ВариантыРедактораКода();
//
//	КлючДанныхБиблиотекиВзаимодействия = УИ_РедакторКодаКлиентСервер.ИмяБиблиотекиВзаимодействияДляДанныхФормы(ВидРедактора);
//	Если ВидРедактора = ВариантыРедактора.Ace Тогда
//		Форма[ИмяРеквизитаДанныеБиблиотекРедакторов].Вставить(КлючДанныхБиблиотекиВзаимодействия,
//															  ПоместитьВоВременноеХранилище(ДанныеБиблиотекиОбщегоМакета("УИ_AceColaborator",
//																														 Форма.УникальныйИдентификатор),
//																							Форма.УникальныйИдентификатор));
//	КонецЕсли;
	
КонецПроцедуры

// Данные библиотеки редактора.
// 
// Параметры:
//  ИдентификаторФормы -УникальныйИдентификатор-Идентификатор формы
//  ПараметрыФормированияРедакторов - см. УИ_РедакторКодаКлиентСервер.НовыйПараметрыФормированияРедакторов
//  ВидРедактора - Строка, Неопределено -  Вид редактора
// 
// Возвращаемое значение:
// 	см. УИ_РедакторКодаКлиентСервер.НовыйБиблиотекаРедактораКодаФормы
// Возвращаемое значение:
// 	Неопределено - Нет подходящего макета для такой библиотеки
Функция ДанныеБиблиотекиРедактора(ИдентификаторФормы, ПараметрыФормированияРедакторов, ВидРедактора = Неопределено)
	Если ВидРедактора = Неопределено Тогда
		ВидРедактора = ТекущийВариантРедактораКода1С();
	КонецЕсли;
	
	ВариантыРедактора = УИ_РедакторКодаКлиентСервер.ВариантыРедактораКода();

	Если ВидРедактора = ВариантыРедактора.Monaco Тогда
		Если ПараметрыФормированияРедакторов.ЭтоВебКлиент Тогда
			ИмяМакета="УИ_MonacoEditor";
		ИначеЕсли ПараметрыФормированияРедакторов.ЭтоWindowsКлиент
				  Или УИ_ОбщегоНазначенияКлиентСервер.ВерсияПлатформыНеМладше("8.3.24") Тогда
			ИмяМакета="УИ_MonacoEditorWindows";
		Иначе
			ИмяМакета="УИ_MonacoEditor";
		КонецЕсли;
	ИначеЕсли ВидРедактора = ВариантыРедактора.Ace Тогда
		ИмяМакета="УИ_Ace";
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
	БиблиотекаРедактора = УИ_РедакторКодаКлиентСервер.НовыйБиблиотекаРедактораКодаФормы();
	БиблиотекаРедактора.ИмяМакета = ИмяМакета;
	БиблиотекаРедактора.НеобходимоРаспаковатьНаКлиенте = Не ПараметрыФормированияРедакторов.ЭтоВебКлиент;
	БиблиотекаРедактора.ВидРедактора = ВидРедактора;

	СтруктураБиблиотеки = ДанныеБиблиотекиОбщегоМакета(ИмяМакета,
													   ИдентификаторФормы,
													   БиблиотекаРедактора.НеобходимоРаспаковатьНаКлиенте);

	БиблиотекаРедактора.ДанныеБиблиотеки = ПоместитьВоВременноеХранилище(СтруктураБиблиотеки, ИдентификаторФормы);

	Возврат БиблиотекаРедактора;

КонецФункции

// Текст поля HTMLРедактора ace.
// 
// Параметры:
//  ДанныеБиблиотеки - см. УИ_РедакторКодаКлиентСервер.НовыйДанныеБиблиотекиРедактора
// 
// Возвращаемое значение:
//  Строка
Функция ТекстПоляHTMLРедактораAce(ДанныеБиблиотеки)
	ТекстHTML =
	"<!doctype html>
	|<html lang=""ru"">
	|
	|<head>
	|  <meta charset=""UTF-8"" />
	|  <meta name=""viewport"" content=""width=device-width,initial-scale=1"" />
	|  <meta http-equiv=""X-UA-Compatible"" content=""ie=edge"" />
	|  <title>Ace editor for 1C</title>
	|";
	
	Для Каждого ТекСтиль Из ДанныеБиблиотеки.Стили Цикл
		ТекстHTML = ТекстHTML + "
		|<style>
		|"+ТекСтиль+"
		|</style>";
	КонецЦикла;	
	
	ТекстHTML=ТекстHTML+"
	|</head>
	|
	|<body>
	|  <div id=""editor""></div>
	|  <div id=""statusBar""></div>
	|";


	Для Каждого ТекСкрипт Из ДанныеБиблиотеки.Скрипты Цикл
		ТекстHTML=ТекстHTML + "
							  |  <script src=""" + ТекСкрипт + """ defer></script>";
	КонецЦикла;

	ТекстHTML= ТекстHTML + "
						   |</body>
						   |
						   |</html>";

	Возврат ТекстHTML;
КонецФункции

// Текст поля HTMLРедактора monaco.
// 
// Параметры:
//  БиблиотекаРедактора - см. УИ_РедакторКодаКлиентСервер.НовыйБиблиотекаРедактораКодаФормы
// 
// Возвращаемое значение:
//  Строка
Функция ТекстПоляHTMLРедактораMonaco(БиблиотекаРедактора)
	ДанныеБиблиотеки = ПолучитьИзВременногоХранилища(БиблиотекаРедактора.ДанныеБиблиотеки); //см. УИ_РедакторКодаКлиентСервер.НовыйДанныеБиблиотекиРедактора

	АдресДанныхИндекса = ДанныеБиблиотеки.ДанныеФайлов["index.html"];
	ТекстHTML = ТекстИзДвоичныхДанных(ПолучитьИзВременногоХранилища(АдресДанныхИндекса));
	
	ТекстВставки = "";
	Для Каждого  ТекФ Из ДанныеБиблиотеки.Скрипты Цикл  
		ТекстСкрипта = ТекстИзДвоичныхДанных(ПолучитьИзВременногоХранилища(ТекФ));
		ТекстВставки = ТекстВставки+"<script>"+ТекстСкрипта+"</script>";	
	КонецЦикла;
	
	ТекстHTML = СтрЗаменить(ТекстHTML, "<body>", "<body>"+ТекстВставки);     
	
	ТекстВставки = "<script>
	|
				   |window.sendEvent = function(eventName, eventParams) {
//				   |  window.events_queue.push({event : eventName, params: eventParams});
				   |  setTimeout(() => {
				   |  	var lastEvent = new CustomEvent('click', {
				   |    bubbles: true,
				   |    cancelable: true,
				   |    composed: false,
				   |    detail: {
				   |      event: eventName,
				   |      params: eventParams
				   |    }
				   |  })
				   |  lastEvent.preventDefault()
				   |  document.body.dispatchEvent(lastEvent)
				   |  }, 10);  
				   |  
				   |}
				   |
				   |</script>";
	ТекстHTML = СтрЗаменить(ТекстHTML, "</body>", ТекстВставки+ "</body>");     
	
	Возврат ТекстHTML;
КонецФункции

// Текст из двоичных данных.
// 
// Параметры:
//  ДвоичныеДанные -ДвоичныеДанные- 
// 
// Возвращаемое значение:
//  Строка - Текст из двоичных данных
Функция ТекстИзДвоичныхДанных(ДвоичныеДанные) 
	Текст = Новый ТекстовыйДокумент();
	Текст.Прочитать(ДвоичныеДанные.ОткрытьПотокДляЧтения(), КодировкаТекста.UTF8);
	
	Возврат Текст.ПолучитьТекст();
КонецФункции

#КонецОбласти