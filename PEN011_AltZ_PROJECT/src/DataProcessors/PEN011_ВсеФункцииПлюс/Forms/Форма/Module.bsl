&AtServer
Procedure FillTree(Row, TableRows)
	TableRows.Sort("Name");
	
	For i = 0 to TableRows.Count() - 1 Do
		Element = TableRows.Get(i);
		SubString = Row.GetItems().Add();	
		SubString.Name = Element.Name;
		SubString.Form = Element.Form;
		SubString.Picture = Element.Picture;
		SubString.Type = Element.Type;
        If Element.Rows.Count() <> 0 Then
            FillTree(SubString, Element.Rows);
        EndIf;
	EndDo;
	
	TableRows.Clear();
EndProcedure
	
&AtServer
Procedure OnCreateAtServer(Cancel, StandardProcessing)
	
	Var ActiveUsers;
	Var DatabaseCopiesManagementObjects;
	Var DocumentsPosting;
	Var ECSRegister;
	Var EventLog;
	Var ExtensionsManagement;
	Var ExternalDataSourcesManagementObjects;
	Var FullTextSearchCtrl;
	Var ReferenceFind;
	Var RemoveMarkedObjects;
	Var ServersControl;
	Var StandardDataChangeHistory;
	Var TotalsManagement;
	
	PictureLibConstant = PictureLib.Constant;
	PictureLibCatalog = PictureLib.Catalog;
	PictureLibDocument = PictureLib.Document;
	PictureLibDocumentJournal = PictureLib.DocumentJournal;
	PictureLibReport = PictureLib.Report;
	PictureLibDataProcessor = PictureLib.DataProcessor;
	PictureLibChartOfCharacteristicTypes = PictureLib.ChartOfCharacteristicTypes;
	PictureLibChartOfAccounts = PictureLib.ChartOfAccounts;
	PictureLibChartOfCalculationTypes = PictureLib.ChartOfCalculationTypes;
	PictureLibInformationRegister = PictureLib.InformationRegister;
	PictureLibAccumulationRegister = PictureLib.AccumulationRegister;
	PictureLibAccountingRegister = PictureLib.AccountingRegister;
	PictureLibCalculationRegister = PictureLib.CalculationRegister;
	PictureLibBusinessProcess = PictureLib.BusinessProcess;
	PictureLibTask = PictureLib.Task;
	PictureLibExternalDataSource = PictureLib.ExternalDataSource;
	PictureLibExternalDataSourceTable = PictureLib.ExternalDataSourceTable;
	PictureLibExternalDataSourceCubeDimensionTable = PictureLib.ExternalDataSourceCubeDimensionTable;
	PictureLibExchangePlan = PictureLib.ExchangePlan;
	PictureLibForm = PictureLib.Form;
	PictureLibExternalDataSourceCube = PictureLib.ExternalDataSourceCube;
	
	Table = New ValueTree;
	Table.Columns.Add("Name");
	Table.Columns.Add("Form");
	Table.Columns.Add("Picture");
	Table.Columns.Add("Type");
	
	NeedControlTotals = False;
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Константы'; SYS = 'AllFunctions.Constants'", "ru");
	Row.Picture = PictureLibConstant;
	
	For i = 0 to Metadata.Constants.Count() - 1 Do
		Element = Metadata.Constants.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".ConstantsForm";
			SubString.Picture = PictureLibConstant;
			SubString.Type = "Form";
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Справочники'; SYS = 'AllFunctions.References'", "ru");
	Row.Picture = PictureLibCatalog;
	
	For i = 0 to Metadata.Catalogs.Count() - 1 Do
		Element = Metadata.Catalogs.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".ListForm";
			SubString.Picture = PictureLibCatalog;
			SubString.Type = "ListForm";
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Документы'; SYS = 'AllFunctions.Documents'", "ru");
	Row.Picture = PictureLibDocument;
	
	For i = 0 to Metadata.Documents.Count() - 1 Do
		Element = Metadata.Documents.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".ListForm";
			SubString.Picture = PictureLibDocument;
			SubString.Type = "ListForm";
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Журналы документов'; SYS = 'AllFunctions.DocJounals'", "ru");
	Row.Picture = PictureLibDocumentJournal;
	
	For i = 0 to Metadata.DocumentJournals.Count() - 1 Do
		Element = Metadata.DocumentJournals.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".ListForm";
			SubString.Picture = PictureLibDocumentJournal;
			SubString.Type = "ListForm";
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Отчеты'; SYS = 'AllFunctions.Reports'", "ru");
	Row.Picture = PictureLibReport;
	
	For i = 0 to Metadata.Reports.Count() - 1 Do
		Element = Metadata.Reports.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".Form";
			SubString.Picture = PictureLibReport;
			SubString.Type = "Form";
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Обработки'; SYS = 'AllFunctions.Processings'", "ru");
	Row.Picture = PictureLibDataProcessor;
	
	For i = 0 to Metadata.DataProcessors.Count() - 1 Do
		Element = Metadata.DataProcessors.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".Form";
			SubString.Picture = PictureLibDataProcessor;
			SubString.Type = "Form";
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Планы видов характеристик'; SYS = 'AllFunctions.ПВХ'", "ru");
	Row.Picture = PictureLibChartOfCharacteristicTypes;
	
	For i = 0 to Metadata.ChartsOfCharacteristicTypes.Count() - 1 Do
		Element = Metadata.ChartsOfCharacteristicTypes.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".ListForm";
			SubString.Picture = PictureLibChartOfCharacteristicTypes;
			SubString.Type = "ListForm";
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Планы счетов'; SYS = 'AllFunctions.ChartsOfAccounts'", "ru");
	Row.Picture = PictureLibChartOfAccounts;
	
	For i = 0 to Metadata.ChartsOfAccounts.Count() - 1 Do
		Element = Metadata.ChartsOfAccounts.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".ListForm";
			SubString.Picture = PictureLibChartOfAccounts;
			SubString.Type = "ListForm";
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Планы видов расчета'; SYS = 'AllFunctions.CalcKinds'", "ru");
	Row.Picture = PictureLibChartOfCalculationTypes;
	
	For i = 0 to Metadata.ChartsOfCalculationTypes.Count() - 1 Do
		Element = Metadata.ChartsOfCalculationTypes.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".ListForm";
			SubString.Picture = PictureLibChartOfCalculationTypes;
			SubString.Type = "ListForm";
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Регистры сведений'; SYS = 'AllFunctions.InfoRegs'", "ru");
	Row.Picture = PictureLibInformationRegister;
	
	For i = 0 to Metadata.InformationRegisters.Count() - 1 Do
		Element = Metadata.InformationRegisters.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".ListForm";
			SubString.Picture = PictureLibInformationRegister;
			SubString.Type = "ListForm";
		EndIf;
		If (Not NeedControlTotals) And AccessRight("TotalsControl", Element) Then
			NeedControlTotals = True;
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Регистры накопления'; SYS = 'AllFunctions.AccumRegs'", "ru");
	Row.Picture = PictureLibAccumulationRegister;
	
	For i = 0 to Metadata.AccumulationRegisters.Count() - 1 Do
		Element = Metadata.AccumulationRegisters.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".ListForm";
			SubString.Picture = PictureLibAccumulationRegister;
			SubString.Type = "ListForm";
		EndIf;
		If (Not NeedControlTotals) And AccessRight("TotalsControl", Element) Then
			NeedControlTotals = True;
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Регистры бухгалтерии'; SYS = 'AllFunctions.AccntRegs'", "ru");
	Row.Picture = PictureLibAccountingRegister;
	
	For i = 0 to Metadata.AccountingRegisters.Count() - 1 Do
		Element = Metadata.AccountingRegisters.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".ListForm";
			SubString.Picture = PictureLibAccountingRegister;
			SubString.Type = "ListForm";
		EndIf;
		If (Not NeedControlTotals) And AccessRight("TotalsControl", Element) Then
			NeedControlTotals = True;
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Регистры расчета'; SYS = 'AllFunctions.CalcRegs'", "ru");
	Row.Picture = PictureLibCalculationRegister;
	
	For i = 0 to Metadata.CalculationRegisters.Count() - 1 Do
		Element = Metadata.CalculationRegisters.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".ListForm";
			SubString.Picture = PictureLibCalculationRegister;
			SubString.Type = "ListForm";
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Бизнес процессы'; SYS = 'AllFunctions.BP'", "ru");
	Row.Picture = PictureLibBusinessProcess;
	
	For i = 0 to Metadata.BusinessProcesses.Count() - 1 Do
		Element = Metadata.BusinessProcesses.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".ListForm";
			SubString.Picture = PictureLibBusinessProcess;
			SubString.Type = "ListForm";
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Задачи'; SYS = 'AllFunctions.Tasks'", "ru");
	Row.Picture = PictureLibTask;
	
	For i = 0 to Metadata.Tasks.Count() - 1 Do
		Element = Metadata.Tasks.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".ListForm";
			SubString.Picture = PictureLibTask;
			SubString.Type = "ListForm";
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Внешние источники данных'; SYS = 'AllFunctions.ExternalDataSources'", "ru");
	Row.Picture = PictureLibExternalDataSource;
	
	For i = 0 to Metadata.ExternalDataSources.Count() - 1 Do
		Element = Metadata.ExternalDataSources.Get(i);
		If AccessRight("Use", Element) Then
			ExternalDataSourceRow = Table.Rows.Add();
			ExternalDataSourceRow.Name = Element.Presentation();
			ExternalDataSourceRow.Picture = PictureLibExternalDataSource;
            For Each ExternalDataSourceTableMetadata In Element.Tables Do
        		If AccessRight("View", ExternalDataSourceTableMetadata) Then
                    ExternalDataSourceTableRow = ExternalDataSourceRow.Rows.Add();
        			ExternalDataSourceTableRow.Name = ExternalDataSourceTableMetadata.Presentation();
        			ExternalDataSourceTableRow.Form = ExternalDataSourceTableMetadata.FullName() + ".ListForm";
        			ExternalDataSourceTableRow.Picture = PictureLibExternalDataSourceTable;
        			ExternalDataSourceTableRow.Type = "ListForm";
                EndIf;
			EndDo;
			Try
				For Each CubeMetadata In Element.Cubes Do
	        		If AccessRight("View", CubeMetadata) Then
	                    CubeRow = ExternalDataSourceRow.Rows.Add();
	        			CubeRow.Name = CubeMetadata.Presentation();
	        			CubeRow.Form = CubeMetadata.FullName() + ".ListForm";
	        			CubeRow.Picture = PictureLibExternalDataSourceCube;
	        			CubeRow.Type = "ListForm";
						
						For Each DimTableMetadata In CubeMetadata.DimensionTables Do
			        		If AccessRight("View", DimTableMetadata) Then
			                    DimTableRow = CubeRow.Rows.Add();
			        			DimTableRow.Name = DimTableMetadata.Presentation();
			        			DimTableRow.Form = DimTableMetadata.FullName() + ".ListForm";
			        			DimTableRow.Picture = PictureLibExternalDataSourceCubeDimensionTable;
			        			DimTableRow.Type = "ListForm";
							EndIf;
						EndDo;
					EndIf;
				EndDo;
			Except
			EndTry;
        EndIf;
	EndDo;
    FillTree(Row, Table.Rows);
    
    Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Планы обмена'; SYS = 'AllFunctions.DataExchanges'", "ru");
	Row.Picture = PictureLibExchangePlan;
	
	For i = 0 to Metadata.ExchangePlans.Count() - 1 Do
		Element = Metadata.ExchangePlans.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".ListForm";
			SubString.Picture = PictureLibExchangePlan;
			SubString.Type = "ListForm";
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	/////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Стандартные'; SYS = 'AllFunctions.Standard'", "ru");
	Row.Picture = PictureLibForm;

	LanguageCode = CurrentSystemLanguage();
	/////////////////////////////////////////////////////////////////////////////////
	StandardActiveUsers = ПолучитьЗначениеИзОбщихНастроек("StandardActiveUsers", LanguageCode);
	StandardMobileAppBuilderServiceLoader = ПолучитьЗначениеИзОбщихНастроек("StandardMobileAppBuilderServiceLoader", LanguageCode);
	StandardEventLog = ПолучитьЗначениеИзОбщихНастроек("StandardEventLog", LanguageCode);
	StandardFullTextSearchManagement = ПолучитьЗначениеИзОбщихНастроек("StandardFullTextSearchManagement", LanguageCode);
	StandardBinaryDataStorageManagement = ПолучитьЗначениеИзОбщихНастроек("StandardBinaryDataStorageManagement", LanguageCode);
	StandardFindByReference = ПолучитьЗначениеИзОбщихНастроек("StandardFindByReference", LanguageCode);
	StandardDeleteMarkedObjects = ПолучитьЗначениеИзОбщихНастроек("StandardDeleteMarkedObjects", LanguageCode);
	StandardDocumentsPosting = ПолучитьЗначениеИзОбщихНастроек("StandardDocumentsPosting", LanguageCode);
	StandardTotalsManagement = ПолучитьЗначениеИзОбщихНастроек("StandardTotalsManagement", LanguageCode);
	StandardExternalDataSourcesManagement = ПолучитьЗначениеИзОбщихНастроек("StandardExternalDataSourcesManagement", LanguageCode);
	StandardDataBaseCopiesManagement = ПолучитьЗначениеИзОбщихНастроек("StandardDataBaseCopiesManagement", LanguageCode);
	StandardSpeechToText = ПолучитьЗначениеИзОбщихНастроек("StandardSpeechToText", LanguageCode);
	StandardAnalyticsSystemManagement = ПолучитьЗначениеИзОбщихНастроек("StandardAnalyticsSystemManagement", LanguageCode);
	StandardConfigurationExtensionsManagement = ПолучитьЗначениеИзОбщихНастроек("StandardConfigurationExtensionsManagement", LanguageCode);
	StandardCollaborationSystemManagement = ПолучитьЗначениеИзОбщихНастроек("StandardCollaborationSystemManagement", LanguageCode);
	StandardServersManagement = ПолучитьЗначениеИзОбщихНастроек("StandardServersManagement", LanguageCode);
	StandardDataChangeHistory = ПолучитьЗначениеИзОбщихНастроек("StandardDataChangeHistory", LanguageCode);
	StandardErrorProcessingSettings = ПолучитьЗначениеИзОбщихНастроек("StandardErrorProcessingSettings", LanguageCode);
	StandardIntegrationServicesManagment = ПолучитьЗначениеИзОбщихНастроек("StandardIntegrationServicesManagment", LanguageCode);
	StandardUserList = ПолучитьЗначениеИзОбщихНастроек("StandardUserList", LanguageCode);
	StandardInfobaseParameters = ПолучитьЗначениеИзОбщихНастроек("StandardInfobaseParameters", LanguageCode);
	StandardAdditionalAuthenticationSettings = ПолучитьЗначениеИзОбщихНастроек("StandardAdditionalAuthenticationSettings", LanguageCode);
	StandardAuthenticationLocks = ПолучитьЗначениеИзОбщихНастроек("StandardAuthenticationLocks", LanguageCode);
	StandardConfigurationLicense = ПолучитьЗначениеИзОбщихНастроек("StandardConfigurationLicense", LanguageCode);
	StandardEventLogSettings = ПолучитьЗначениеИзОбщихНастроек("StandardEventLogSettings", LanguageCode);
	StandardLicenseAcquisition = ПолучитьЗначениеИзОбщихНастроек("StandardLicenseAcquisition", LanguageCode);
	StandardDatabaseTablespaceManagement = ПолучитьЗначениеИзОбщихНастроек("StandardDatabaseTablespaceManagement", LanguageCode);
	StandardInfobaseRegionalSettings = ПолучитьЗначениеИзОбщихНастроек("StandardInfobaseRegionalSettings", LanguageCode);
		
	If AccessRight("ActiveUsers", Metadata) And StandardActiveUsers Then
			SubString = Table.Rows.Add();	
			SubString.Name = NStr("ru = 'Активные пользователи'; SYS = 'AllFunctions.ActiveUsers'", "ru");
			SubString.Form = "ExternalDataProcessor.StandardActiveUsers.Form";
			SubString.Picture = PictureLibForm;
			SubString.Type = "ExternalForm";
	EndIf;
	
	If AccessRight("Administration", Metadata) 
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_13
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_16
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_2
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_3
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_4
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_5
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_6
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_7
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_8
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_9
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_10
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_11
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_12
			And StandardMobileAppBuilderServiceLoader Then
			SubString = Table.Rows.Add();	
			SubString.Name = NStr("ru = 'Сервис сборки мобильных приложений'; SYS = 'AllFunctions.MobileAppBuilder'", "ru");
			SubString.Form = "ExternalDataProcessor.StandardMobileAppBuilderServiceLoader.Form";
			SubString.Picture = PictureLib.Form;
			SubString.Type = "ExternalForm";

	EndIf;
	
	/////////////////////////////////////////////////////////////////////////////////
	If AccessRight("EventLog", Metadata) And StandardEventLog Then
			SubString = Table.Rows.Add();	
			SubString.Name = NStr("ru = 'Журнал регистрации'; SYS = 'AllFunctions.RegJournal'", "ru");
			SubString.Form = "ExternalDataProcessor.StandardEventLog.Form";
			SubString.Picture = PictureLib.Form;
			SubString.Type = "ExternalForm";
	EndIf;
	
	/////////////////////////////////////////////////////////////////////////////////
	If AccessRight("Administration", Metadata) And StandardFullTextSearchManagement Then
			SubString = Table.Rows.Add();	
			SubString.Name = NStr("ru = 'Управление полнотекстовым поиском'; SYS = 'AllFunctions.FullTextSearch'", "ru");
			SubString.Form = "ExternalDataProcessor.StandardFullTextSearchManagement.Form";
			SubString.Picture = PictureLib.Form;
			SubString.Type = "ExternalForm";
	EndIf;

	/////////////////////////////////////////////////////////////////////////////////
	If AccessRight("Administration", Metadata) And StandardBinaryDataStorageManagement Then
		If Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_13
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_16
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_2
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_3
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_4
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_5
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_6
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_7
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_8
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_9 
			And (
				(
					Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_10
					And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_11
					And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_12
					And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_13
					And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_14
					And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_15
					And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_16
					And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_17
					And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_18
					And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_19
					And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_20
					And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_21
				)
				Or Metadata.BinaryDataStorageMode <> Metadata.ObjectProperties.BinaryDataStorageMode.DontUse
			) Then
						SubString = Table.Rows.Add();		
						SubString.Name = NStr("ru = 'Список хранилищ двоичных данных'; SYS = 'AllFunctions.BinaryDataStorageManagement'", "ru");
						SubString.Form = "ExternalDataProcessor.StandardBinaryDataStorageManagement.Form";
						SubString.Picture = PictureLib.Form;
						SubString.Type = "ExternalForm";
		EndIf;
	EndIf;

	/////////////////////////////////////////////////////////////////////////////////
		SubString = Table.Rows.Add();	
		SubString.Name = NStr("ru = 'Поиск ссылок на объект'; SYS = 'AllFunctions.FindObjectsReferences'", "ru");
		SubString.Form = "ExternalDataProcessor.StandardFindByReference.Form";
		SubString.Picture = PictureLib.Form;
		SubString.Type = "ExternalForm";
	
	/////////////////////////////////////////////////////////////////////////////////
	If AccessRight("ExclusiveMode", Metadata) And StandardDeleteMarkedObjects Then
			SubString = Table.Rows.Add();	
			SubString.Name = NStr("ru = 'Удаление помеченных объектов'; SYS = 'AllFunctions.DeleteMarkedObjects'", "ru");
			SubString.Form = "ExternalDataProcessor.StandardDeleteMarkedObjects.Form";
			SubString.Picture = PictureLib.Form;
			SubString.Type = "ExternalForm";
	EndIf;
	
	/////////////////////////////////////////////////////////////////////////////////
	if StandardDocumentsPosting Then
		SubString = Table.Rows.Add();	
		SubString.Name = NStr("ru = 'Проведение документов'; SYS = 'AllFunctions.DocumentPostiong'", "ru");
		SubString.Form = "ExternalDataProcessor.StandardDocumentsPosting.Form";
		SubString.Picture = PictureLib.Form;
		SubString.Type = "ExternalForm";
	EndIf;
	/////////////////////////////////////////////////////////////////////////////////
	If NeedControlTotals And StandardTotalsManagement Then
			SubString = Table.Rows.Add();	
			SubString.Name = NStr("ru = 'Управление итогами'; SYS = 'AllFunctions.TotalsManagement'", "ru");
			SubString.Form = "ExternalDataProcessor.StandardTotalsManagement.Form";
			SubString.Picture = PictureLib.Form;
			SubString.Type = "ExternalForm";
	EndIf;
    
	/////////////////////////////////////////////////////////////////////////////////
    // Работа со вншними источниками данных.
	if StandardExternalDataSourcesManagement then 
		SubString = Table.Rows.Add();	
        SubString.Name = NStr("ru = 'Управление внешними источниками данных'; SYS = 'AllFunctions.StandardExternalDataSourcesManagement'", "ru");
        SubString.Form = "ExternalDataProcessor.StandardExternalDataSourcesManagement.Form";
        SubString.Picture = PictureLib.Form;
        SubString.Type = "ExternalForm";
	EndIf;
	/////////////////////////////////////////////////////////////////////////////////
	If AccessRight("Administration", Metadata) 
		Or AccessRight("DataAdministration", Metadata) Then
		If Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_13
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_16
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_2
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_3
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_4
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_5
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_6
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_7
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_8
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_9
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_10
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_11
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_12
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_13
			And StandardDataBaseCopiesManagement Then
			
			        SubString = Table.Rows.Add();	
		        SubString.Name = NStr("ru = 'Управление копиями базы данных'; SYS = 'AllFunctions.StandardDataBaseCopiesManagement'", "ru");
		        SubString.Form = "ExternalDataProcessor.StandardDataBaseCopiesManagement.Form";
		        SubString.Picture = PictureLib.Form;
		        SubString.Type = "ExternalForm";
		EndIf;
  EndIf;

  /////////////////////////////////////////////////////////////////////////////////
  If Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_1
        And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_13
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_16
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_1
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_2
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_3
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_4
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_5
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_6
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_7
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_8 
		And StandardSpeechToText Then

           SubString = Table.Rows.Add();
          SubString.Name = NStr("ru = 'Управление распознаванием речи'; SYS = 'AllFunctions.StandardSpeechToText'", "ru");
          SubString.Form = "ExternalDataProcessor.StandardSpeechToText.Form";
          SubString.Picture = PictureLib.Form;
          SubString.Type = "ExternalForm";
  EndIf;

  /////////////////////////////////////////////////////////////////////////////////
  If AccessRight("Administration", Metadata) Then
		If Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_13
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_16
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_2
      And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_3
      And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_4
      And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_5
	  And StandardAnalyticsSystemManagement Then
      
        SubString = Table.Rows.Add();	
        SubString.Name = NStr("ru = 'Управление системой аналитики'; SYS = 'AllFunctions.AnalyticsSystemManagement'", "ru");
        SubString.Form = "ExternalDataProcessor.StandardAnalyticsSystemManagement.Form";
        SubString.Picture = PictureLib.Form;
        SubString.Type = "ExternalForm";
    EndIf;
	EndIf;
	
	/////////////////////////////////////////////////////////////////////////////////
	If AccessRight("ConfigurationExtensionsAdministration", Metadata) And StandardConfigurationExtensionsManagement Then
			SubString = Table.Rows.Add();	
			SubString.Name = NStr("ru = 'Управление расширениями конфигурации'; SYS = 'AllFunctions.ExtensionsManagement'", "ru");
			SubString.Form = "ExternalDataProcessor.StandardConfigurationExtensionsManagement.Form";
			SubString.Picture = PictureLib.Form;
			SubString.Type = "ExternalForm";
	EndIf;
	
	/////////////////////////////////////////////////////////////////////////////////
	If AccessRight("CollaborationSystemInfoBaseRegistration", Metadata) AND
	   InfoBaseUsers.CurrentUser().Name <> "" AND StandardCollaborationSystemManagement 
	Then
			SubString = Table.Rows.Add();	
			SubString.Name = NStr("ru = 'Управление системой взаимодействия'; SYS = 'AllFunctions.ColaborationSystemManagement'", "ru");
			SubString.Form = "ExternalDataProcessor.StandardCollaborationSystemManagement.Form";
			SubString.Picture = PictureLib.Form;
			SubString.Type = "ExternalForm";
	EndIf;
	
	/////////////////////////////////////////////////////////////////////////////////
	If AccessRight("Administration", Metadata) And StandardServersManagement Then
			SubString = Table.Rows.Add();	
			SubString.Name = NStr("ru = 'Управление серверами'; SYS = 'AllFunctions.ServersControl'", "ru");
			SubString.Form = "ExternalDataProcessor.StandardServersManagement.Form";
			SubString.Picture = PictureLib.Form;
			SubString.Type = "ExternalForm";
	EndIf; 
		
	
	/////////////////////////////////////////////////////////////////////////////////
	If Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_1
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_13
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_16
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_1
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_2
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_3
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_4
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_5
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_6
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_7
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_8
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_9
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_10
		And StandardDataChangeHistory Then
			
			SubString = Table.Rows.Add();	
			SubString.Name = NStr("ru = 'История изменений данных'; SYS = 'AllFunctions.DataChangeHistory'", "ru");
			SubString.Form = "ExternalDataProcessor.StandardDataChangeHistory.Form";
			SubString.Picture = PictureLib.Form;
			SubString.Type = "ExternalForm";

			
	EndIf;
	
	/////////////////////////////////////////////////////////////////////////////////
	If AccessRight("DataAdministration", Metadata) And StandardErrorProcessingSettings Then	
			SubString = Table.Rows.Add();	
			SubString.Name = NStr("ru = 'Управление настройками обработки ошибок'; SYS = 'AllFunctions.StandardErrorProcessingSettings'", "ru");
			SubString.Form = "ExternalDataProcessor.StandardErrorProcessingSettings.Form";
			SubString.Picture = PictureLib.Form;
			SubString.Type = "ExternalForm";
	EndIf;
	
	/////////////////////////////////////////////////////////////////////////////////
	If  (AccessRight("Administration", Metadata) 
		Or AccessRight("DataAdministration", Metadata)) And StandardIntegrationServicesManagment Then	
			SubString = Table.Rows.Add();	
			SubString.Name = NStr("ru = 'Управление сервисами интеграции'; SYS = 'AllFunctions.StandardIntegrationServicesManagment'", "ru");
			SubString.Form = "ExternalDataProcessor.StandardIntegrationServicesManagment.Form";
			SubString.Picture = PictureLib.Form;
			SubString.Type = "ExternalForm";
	EndIf;
	
	/////////////////////////////////////////////////////////////////////////////////
	If AccessRight("Administration", Metadata) Then
		If Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_13
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_16
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_2
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_3
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_4
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_5 
			And StandardUserList Then
			
				SubString = Table.Rows.Add();	
				SubString.Name = NStr("ru = 'Пользователи'; SYS = 'AllFunctions.UserList'", "ru");
				SubString.Form = "ExternalDataProcessor.StandardUserList.Form";
				SubString.Picture = PictureLib.Form;
				SubString.Type = "ExternalForm";
		EndIf;
	EndIf;
	
	/////////////////////////////////////////////////////////////////////////////////
	If AccessRight("Administration", Metadata) Then
		If Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_13
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_16
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_2
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_3
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_4
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_5
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_6
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_7
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_8 
			And StandardInfobaseParameters Then
			
				SubString = Table.Rows.Add();	
				SubString.Name = NStr("ru = 'Параметры информационной базы'; SYS = 'AllFunctions.InfobaseParameters'", "ru");
				SubString.Form = "ExternalDataProcessor.StandardInfobaseParameters.Form";
				SubString.Picture = PictureLib.Form;
				SubString.Type = "ExternalForm";
		EndIf;
	EndIf;

	/////////////////////////////////////////////////////////////////////////////////
	If AccessRight("Administration", Metadata) Then
		If Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_13
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_16
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_2
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_3
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_4
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_5 
			And StandardAdditionalAuthenticationSettings Then
			
				SubString = Table.Rows.Add();	
				SubString.Name = NStr("ru = 'Дополнительные настройки аутентификации'; SYS = 'AllFunctions.AdditionalAuthenticationSettings'", "ru");
				SubString.Form = "ExternalDataProcessor.StandardAdditionalAuthenticationSettings.Form";
				SubString.Picture = PictureLib.Form;
				SubString.Type = "ExternalForm";
		EndIf;
	EndIf;
	
	/////////////////////////////////////////////////////////////////////////////////
	If AccessRight("Administration", Metadata) Then
		If Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_13
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_16
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_2
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_3
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_4
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_5
			And StandardAuthenticationLocks Then
			
				SubString = Table.Rows.Add();	
				SubString.Name = NStr("ru = 'Блокировка аутентификации'; SYS = 'AllFunctions.AuthenticationLocks'", "ru");
				SubString.Form = "ExternalDataProcessor.StandardAuthenticationLocks.Form";
				SubString.Picture = PictureLib.Form;
				SubString.Type = "ExternalForm";
		EndIf;
	EndIf;
	
	/////////////////////////////////////////////////////////////////////////////////
	If AccessRight("Administration", Metadata) Then
		If Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_13
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_16
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_2
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_3
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_4
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_5 
			And StandardConfigurationLicense Then
			
				SubString = Table.Rows.Add();	
				SubString.Name = NStr("ru = 'Лицензирование конфигураций'; SYS = 'AllFunctions.ConfigurationLicense'", "ru");
				SubString.Form = "ExternalDataProcessor.StandardConfigurationLicense.Form";
				SubString.Picture = PictureLib.Form;
				SubString.Type = "ExternalForm";
		EndIf;
	EndIf;
	
	/////////////////////////////////////////////////////////////////////////////////
	If AccessRight("Administration", Metadata) Then
		If Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_13
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_16
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_2
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_3
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_4
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_5 
			And StandardEventLogSettings Then
			
				SubString = Table.Rows.Add();	
				SubString.Name = NStr("ru = 'Настройка журнала регистрации'; SYS = 'AllFunctions.EventLogOptions'", "ru");
				SubString.Form = "ExternalDataProcessor.StandardEventLogSettings.Form";
				SubString.Picture = PictureLib.Form;
				SubString.Type = "ExternalForm";
		EndIf;
	EndIf;
	
	/////////////////////////////////////////////////////////////////////////////////
	If AccessRight("Administration", Metadata) Then
		If Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_13
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_16
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_2
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_3
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_4
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_5 
			And StandardLicenseAcquisition Then
			
				SubString = Table.Rows.Add();	
				SubString.Name = NStr("ru = 'Получение лицензии'; SYS = 'AllFunctions.LicenseAcquisition'", "ru");
				SubString.Form = "ExternalDataProcessor.StandardLicenseAcquisition.Form";
				SubString.Picture = PictureLib.Form;
				SubString.Type = "ExternalForm";
		EndIf;
	EndIf;
	
	/////////////////////////////////////////////////////////////////////////////////
	If AccessRight("Administration", Metadata) Then
		If Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_13
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_16
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_2
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_3
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_4
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_5
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_6 
			And StandardDatabaseTablespaceManagement Then
			
			DatabaseTableSpaceManagementObjects = Undefined;
		        SubString = Table.Rows.Add();	
		        SubString.Name = NStr("ru = 'Управление табличными пространствами базы данных'; SYS = 'AllFunctions.StandardDatabaseTablespaceManagement'", "ru");
		        SubString.Form = "ExternalDataProcessor.StandardDatabaseTablespaceManagement.Form";
		        SubString.Picture = PictureLib.Form;
		        SubString.Type = "ExternalForm";

		EndIf;
	EndIf;

	
	/////////////////////////////////////////////////////////////////////////////////
	If AccessRight("Administration", Metadata) Then
		If Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_13
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_16
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_2
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_3
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_4
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_5 
			And StandardInfobaseRegionalSettings Then
			
				SubString = Table.Rows.Add();	
				SubString.Name = NStr("ru = 'Региональные установки информационной базы'; SYS = 'AllFunctions.RegionalInfobaseSettings'", "ru");
				SubString.Form = "ExternalDataProcessor.StandardInfobaseRegionalSettings.Form";
				SubString.Picture = PictureLib.Form;
				SubString.Type = "ExternalForm";

		EndIf;
	EndIf;
	
	FillTree(Row, Table.Rows);
	
EndProcedure 

&НаСервере
Процедура ConnectExternal(FormName)
	
	Название = ЛЕВ(СРЕД(ThisForm.SelectedForm, 23, СтрДлина(ThisForm.SelectedForm)), СтрДлина(СРЕД(ThisForm.SelectedForm, 23, СтрДлина(ThisForm.SelectedForm)))-5);		
	Try
		EventLog = New("ExternalDataProcessorObject." + Название);
	Except
		Try
			ExternalDataProcessors.Connect("v8res://mngbase/"+Название+".epf", Название, false);
			EventLog = New("ExternalDataProcessorObject." + Название);
		Except
			//Message(ErrorDescription());
		EndTry;
	EndTry;
	
КонецПроцедуры


&AtClient
Procedure CommandOpen()
	If CanOpenForm() Then
 		SaveFormName();
		Close(True);
	EndIf;
EndProcedure

&AtClient
Procedure CommandCloseCancel()
	Close(False);
EndProcedure

&AtClient
Procedure TableSelection(Item, SelectedRow, Field, StandardProcessing)
	If CanOpenForm() Then
		StandardProcessing = False;
		SaveFormName();
		Close(True);		
	EndIf;
EndProcedure

&AtClient
Procedure SaveFormName()
	ThisForm.SelectedForm = Items.Table.CurrentData.Form; 
	Если СтрНайти(ThisForm.SelectedForm, "ExternalDataProcessor") > 0 Тогда 
		ConnectExternal(ThisForm.SelectedForm);
	КонецЕсли;

	OpenForm(Items.Table.CurrentData.Form, , , 
	                       WindowOpenVariant.SingleWindow);

EndProcedure

&AtClient
Function CanOpenForm()
	If Items.Table.CurrentData <> Undefined and Items.Table.CurrentData.Form <> "" Then
		return true;
	EndIf;	
	return false;
EndFunction

&НаКлиенте
Процедура Перечитать(Команда)
	ПеречитатьНаСервере();
КонецПроцедуры

&НаСервере
Процедура ПеречитатьНаСервере()
			
	Var ActiveUsers;
	Var DatabaseCopiesManagementObjects;
	Var DocumentsPosting;
	Var ECSRegister;
	Var EventLog;
	Var ExtensionsManagement;
	Var ExternalDataSourcesManagementObjects;
	Var FullTextSearchCtrl;
	Var ReferenceFind;
	Var RemoveMarkedObjects;
	Var ServersControl;
	Var StandardDataChangeHistory;
	Var TotalsManagement;
	
	MetadataTree.ПолучитьЭлементы().Очистить();
	
	PictureLibConstant = PictureLib.Constant;
	PictureLibCatalog = PictureLib.Catalog;
	PictureLibDocument = PictureLib.Document;
	PictureLibDocumentJournal = PictureLib.DocumentJournal;
	PictureLibReport = PictureLib.Report;
	PictureLibDataProcessor = PictureLib.DataProcessor;
	PictureLibChartOfCharacteristicTypes = PictureLib.ChartOfCharacteristicTypes;
	PictureLibChartOfAccounts = PictureLib.ChartOfAccounts;
	PictureLibChartOfCalculationTypes = PictureLib.ChartOfCalculationTypes;
	PictureLibInformationRegister = PictureLib.InformationRegister;
	PictureLibAccumulationRegister = PictureLib.AccumulationRegister;
	PictureLibAccountingRegister = PictureLib.AccountingRegister;
	PictureLibCalculationRegister = PictureLib.CalculationRegister;
	PictureLibBusinessProcess = PictureLib.BusinessProcess;
	PictureLibTask = PictureLib.Task;
	PictureLibExternalDataSource = PictureLib.ExternalDataSource;
	PictureLibExternalDataSourceTable = PictureLib.ExternalDataSourceTable;
	PictureLibExternalDataSourceCubeDimensionTable = PictureLib.ExternalDataSourceCubeDimensionTable;
	PictureLibExchangePlan = PictureLib.ExchangePlan;
	PictureLibForm = PictureLib.Form;
	PictureLibExternalDataSourceCube = PictureLib.ExternalDataSourceCube;
	
	//VerifyAccessRights("TechnicalSpecialistMode", Metadata);
	 	
	Table = New ValueTree;
	Table.Columns.Add("Name");
	Table.Columns.Add("Form");
	Table.Columns.Add("Picture");
	Table.Columns.Add("Type");
	
	NeedControlTotals = False;
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Константы'; SYS = 'AllFunctions.Constants'", "ru");
	Row.Picture = PictureLibConstant;
	
	For i = 0 to Metadata.Constants.Count() - 1 Do
		Element = Metadata.Constants.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".ConstantsForm";
			SubString.Picture = PictureLibConstant;
			SubString.Type = "Form";
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Справочники'; SYS = 'AllFunctions.References'", "ru");
	Row.Picture = PictureLibCatalog;
	
	For i = 0 to Metadata.Catalogs.Count() - 1 Do
		Element = Metadata.Catalogs.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".ListForm";
			SubString.Picture = PictureLibCatalog;
			SubString.Type = "ListForm";
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Документы'; SYS = 'AllFunctions.Documents'", "ru");
	Row.Picture = PictureLibDocument;
	
	For i = 0 to Metadata.Documents.Count() - 1 Do
		Element = Metadata.Documents.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".ListForm";
			SubString.Picture = PictureLibDocument;
			SubString.Type = "ListForm";
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Журналы документов'; SYS = 'AllFunctions.DocJounals'", "ru");
	Row.Picture = PictureLibDocumentJournal;
	
	For i = 0 to Metadata.DocumentJournals.Count() - 1 Do
		Element = Metadata.DocumentJournals.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".ListForm";
			SubString.Picture = PictureLibDocumentJournal;
			SubString.Type = "ListForm";
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Отчеты'; SYS = 'AllFunctions.Reports'", "ru");
	Row.Picture = PictureLibReport;
	
	For i = 0 to Metadata.Reports.Count() - 1 Do
		Element = Metadata.Reports.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".Form";
			SubString.Picture = PictureLibReport;
			SubString.Type = "Form";
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Обработки'; SYS = 'AllFunctions.Processings'", "ru");
	Row.Picture = PictureLibDataProcessor;
	
	For i = 0 to Metadata.DataProcessors.Count() - 1 Do
		Element = Metadata.DataProcessors.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".Form";
			SubString.Picture = PictureLibDataProcessor;
			SubString.Type = "Form";
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Планы видов характеристик'; SYS = 'AllFunctions.ПВХ'", "ru");
	Row.Picture = PictureLibChartOfCharacteristicTypes;
	
	For i = 0 to Metadata.ChartsOfCharacteristicTypes.Count() - 1 Do
		Element = Metadata.ChartsOfCharacteristicTypes.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".ListForm";
			SubString.Picture = PictureLibChartOfCharacteristicTypes;
			SubString.Type = "ListForm";
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Планы счетов'; SYS = 'AllFunctions.ChartsOfAccounts'", "ru");
	Row.Picture = PictureLibChartOfAccounts;
	
	For i = 0 to Metadata.ChartsOfAccounts.Count() - 1 Do
		Element = Metadata.ChartsOfAccounts.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".ListForm";
			SubString.Picture = PictureLibChartOfAccounts;
			SubString.Type = "ListForm";
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Планы видов расчета'; SYS = 'AllFunctions.CalcKinds'", "ru");
	Row.Picture = PictureLibChartOfCalculationTypes;
	
	For i = 0 to Metadata.ChartsOfCalculationTypes.Count() - 1 Do
		Element = Metadata.ChartsOfCalculationTypes.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".ListForm";
			SubString.Picture = PictureLibChartOfCalculationTypes;
			SubString.Type = "ListForm";
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Регистры сведений'; SYS = 'AllFunctions.InfoRegs'", "ru");
	Row.Picture = PictureLibInformationRegister;
	
	For i = 0 to Metadata.InformationRegisters.Count() - 1 Do
		Element = Metadata.InformationRegisters.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".ListForm";
			SubString.Picture = PictureLibInformationRegister;
			SubString.Type = "ListForm";
		EndIf;
		If (Not NeedControlTotals) And AccessRight("TotalsControl", Element) Then
			NeedControlTotals = True;
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Регистры накопления'; SYS = 'AllFunctions.AccumRegs'", "ru");
	Row.Picture = PictureLibAccumulationRegister;
	
	For i = 0 to Metadata.AccumulationRegisters.Count() - 1 Do
		Element = Metadata.AccumulationRegisters.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".ListForm";
			SubString.Picture = PictureLibAccumulationRegister;
			SubString.Type = "ListForm";
		EndIf;
		If (Not NeedControlTotals) And AccessRight("TotalsControl", Element) Then
			NeedControlTotals = True;
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Регистры бухгалтерии'; SYS = 'AllFunctions.AccntRegs'", "ru");
	Row.Picture = PictureLibAccountingRegister;
	
	For i = 0 to Metadata.AccountingRegisters.Count() - 1 Do
		Element = Metadata.AccountingRegisters.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".ListForm";
			SubString.Picture = PictureLibAccountingRegister;
			SubString.Type = "ListForm";
		EndIf;
		If (Not NeedControlTotals) And AccessRight("TotalsControl", Element) Then
			NeedControlTotals = True;
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Регистры расчета'; SYS = 'AllFunctions.CalcRegs'", "ru");
	Row.Picture = PictureLibCalculationRegister;
	
	For i = 0 to Metadata.CalculationRegisters.Count() - 1 Do
		Element = Metadata.CalculationRegisters.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".ListForm";
			SubString.Picture = PictureLibCalculationRegister;
			SubString.Type = "ListForm";
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Бизнес процессы'; SYS = 'AllFunctions.BP'", "ru");
	Row.Picture = PictureLibBusinessProcess;
	
	For i = 0 to Metadata.BusinessProcesses.Count() - 1 Do
		Element = Metadata.BusinessProcesses.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".ListForm";
			SubString.Picture = PictureLibBusinessProcess;
			SubString.Type = "ListForm";
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Задачи'; SYS = 'AllFunctions.Tasks'", "ru");
	Row.Picture = PictureLibTask;
	
	For i = 0 to Metadata.Tasks.Count() - 1 Do
		Element = Metadata.Tasks.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".ListForm";
			SubString.Picture = PictureLibTask;
			SubString.Type = "ListForm";
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Внешние источники данных'; SYS = 'AllFunctions.ExternalDataSources'", "ru");
	Row.Picture = PictureLibExternalDataSource;
	
	For i = 0 to Metadata.ExternalDataSources.Count() - 1 Do
		Element = Metadata.ExternalDataSources.Get(i);
		If AccessRight("Use", Element) Then
			ExternalDataSourceRow = Table.Rows.Add();
			ExternalDataSourceRow.Name = Element.Presentation();
			ExternalDataSourceRow.Picture = PictureLibExternalDataSource;
            For Each ExternalDataSourceTableMetadata In Element.Tables Do
        		If AccessRight("View", ExternalDataSourceTableMetadata) Then
                    ExternalDataSourceTableRow = ExternalDataSourceRow.Rows.Add();
        			ExternalDataSourceTableRow.Name = ExternalDataSourceTableMetadata.Presentation();
        			ExternalDataSourceTableRow.Form = ExternalDataSourceTableMetadata.FullName() + ".ListForm";
        			ExternalDataSourceTableRow.Picture = PictureLibExternalDataSourceTable;
        			ExternalDataSourceTableRow.Type = "ListForm";
                EndIf;
			EndDo;
			Try
				For Each CubeMetadata In Element.Cubes Do
	        		If AccessRight("View", CubeMetadata) Then
	                    CubeRow = ExternalDataSourceRow.Rows.Add();
	        			CubeRow.Name = CubeMetadata.Presentation();
	        			CubeRow.Form = CubeMetadata.FullName() + ".ListForm";
	        			CubeRow.Picture = PictureLibExternalDataSourceCube;
	        			CubeRow.Type = "ListForm";
						
						For Each DimTableMetadata In CubeMetadata.DimensionTables Do
			        		If AccessRight("View", DimTableMetadata) Then
			                    DimTableRow = CubeRow.Rows.Add();
			        			DimTableRow.Name = DimTableMetadata.Presentation();
			        			DimTableRow.Form = DimTableMetadata.FullName() + ".ListForm";
			        			DimTableRow.Picture = PictureLibExternalDataSourceCubeDimensionTable;
			        			DimTableRow.Type = "ListForm";
							EndIf;
						EndDo;
					EndIf;
				EndDo;
			Except
			EndTry;
        EndIf;
	EndDo;
    FillTree(Row, Table.Rows);
    
    Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Планы обмена'; SYS = 'AllFunctions.DataExchanges'", "ru");
	Row.Picture = PictureLibExchangePlan;
	
	For i = 0 to Metadata.ExchangePlans.Count() - 1 Do
		Element = Metadata.ExchangePlans.Get(i);
		If AccessRight("View", Element) Then
			SubString = Table.Rows.Add();	
			SubString.Name = Element.Presentation();
			SubString.Form = Element.FullName() + ".ListForm";
			SubString.Picture = PictureLibExchangePlan;
			SubString.Type = "ListForm";
		EndIf;
	EndDo;
	FillTree(Row, Table.Rows);
	
	/////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////
	Row = MetadataTree.GetItems().Add();
	Row.Name = NStr("ru = 'Стандартные'; SYS = 'AllFunctions.Standard'", "ru");
	Row.Picture = PictureLibForm;
	
	/////////////////////////////////////////////////////////////////////////////////
	If AccessRight("ActiveUsers", Metadata) Then
		ActiveUsers = Undefined;
		Try
			ActiveUsers = New("ExternalDataProcessorObject.StandardActiveUsers");
		Except
			Try
				ExternalDataProcessors.Connect("v8res://mngbase/StandardActiveUsers.epf", "StandardActiveUsers", false);
				ActiveUsers = New("ExternalDataProcessorObject.StandardActiveUsers");
			Except
            	//Message(ErrorDescription());
			EndTry;
		EndTry;
		If ActiveUsers <> Undefined Then
			SubString = Table.Rows.Add();	
			SubString.Name = NStr("ru = 'Активные пользователи'; SYS = 'AllFunctions.ActiveUsers'", "ru");
			SubString.Form = "ExternalDataProcessor.StandardActiveUsers.Form";
			SubString.Picture = PictureLibForm;
			SubString.Type = "ExternalForm";
		EndIf;
	EndIf;
	
	/////////////////////////////////////////////////////////////////////////////////
	If AccessRight("EventLog", Metadata) Then
		EventLog = Undefined;
		Try
			EventLog = New("ExternalDataProcessorObject.StandardEventLog");
		Except
			Try
				ExternalDataProcessors.Connect("v8res://mngbase/StandardEventLog.epf", "StandardEventLog", false);
				EventLog = New("ExternalDataProcessorObject.StandardEventLog");
			Except
            	//Message(ErrorDescription());
			EndTry;
		EndTry;
		If EventLog <> Undefined Then
			SubString = Table.Rows.Add();	
			SubString.Name = NStr("ru = 'Журнал регистрации'; SYS = 'AllFunctions.RegJournal'", "ru");
			SubString.Form = "ExternalDataProcessor.StandardEventLog.Form";
			SubString.Picture = PictureLibForm;
			SubString.Type = "ExternalForm";
		EndIf;
	EndIf;
	
	/////////////////////////////////////////////////////////////////////////////////
	If AccessRight("Administration", Metadata) Then
		FullTextSearchCtrl = Undefined;
		Try
			FullTextSearchCtrl = New("ExternalDataProcessorObject.StandardFullTextSearchManagement");
		Except
			Try
				ExternalDataProcessors.Connect("v8res://mngbase/StandardFullTextSearchManagement.epf", "StandardFullTextSearchManagement", false);
				FullTextSearchCtrl = New("ExternalDataProcessorObject.StandardFullTextSearchManagement");
			Except
            	//Message(ErrorDescription());
			EndTry;
		EndTry;
		If FullTextSearchCtrl <> Undefined Then
			SubString = Table.Rows.Add();	
			SubString.Name = NStr("ru = 'Управление полнотекстовым поиском'; SYS = 'AllFunctions.FullTextSearch'", "ru");
			SubString.Form = "ExternalDataProcessor.StandardFullTextSearchManagement.Form";
			SubString.Picture = PictureLibForm;
			SubString.Type = "ExternalForm";
		EndIf;
	EndIf;
	
	/////////////////////////////////////////////////////////////////////////////////
	ReferenceFind = Undefined;
	Try
		ReferenceFind = New("ExternalDataProcessorObject.StandardFindByRef");
	Except
		Try
			ExternalDataProcessors.Connect("v8res://mngbase/StandardFindByRef.epf", "StandardFindByRef", false);
			ReferenceFind = New("ExternalDataProcessorObject.StandardFindByRef");
		Except
			//Message(ErrorDescription());
		EndTry;
	EndTry;
	If ReferenceFind <> Undefined Then
		SubString = Table.Rows.Add();	
		SubString.Name = NStr("ru = 'Поиск ссылок на объекты'; SYS = 'AllFunctions.FindObjectsReferences'", "ru");
		SubString.Form = "ExternalDataProcessor.StandardFindByRef.Form";
		SubString.Picture = PictureLibForm;
		SubString.Type = "ExternalForm";
	EndIf;
	
	/////////////////////////////////////////////////////////////////////////////////
	If AccessRight("ExclusiveMode", Metadata) Then
		RemoveMarkedObjects = Undefined;
		Try
			RemoveMarkedObjects = New("ExternalDataProcessorObject.StandardDeleteMarkedObjects");
		Except
			Try
				ExternalDataProcessors.Connect("v8res://mngbase/StandardDeleteMarkedObjects.epf", "StandardDeleteMarkedObjects", false);
				RemoveMarkedObjects = New("ExternalDataProcessorObject.StandardDeleteMarkedObjects");
			Except
				//Message(ErrorDescription());
			EndTry;
		EndTry;
		If RemoveMarkedObjects <> Undefined Then
			SubString = Table.Rows.Add();	
			SubString.Name = NStr("ru = 'Удаление помеченных объектов'; SYS = 'AllFunctions.DeleteMarkedObjects'", "ru");
			SubString.Form = "ExternalDataProcessor.StandardDeleteMarkedObjects.Form";
			SubString.Picture = PictureLibForm;
			SubString.Type = "ExternalForm";
		EndIf;
	EndIf;
	
	/////////////////////////////////////////////////////////////////////////////////
	DocumentsPosting = Undefined;
	Try
		DocumentsPosting = New("ExternalDataProcessorObject.StandardDocumentsPosting");
	Except
		Try
			ExternalDataProcessors.Connect("v8res://mngbase/StandardDocumentsPosting.epf", "StandardDocumentsPosting", false);
			DocumentsPosting = New("ExternalDataProcessorObject.StandardDocumentsPosting");
		Except
			//Message(ErrorDescription());
		EndTry;
	EndTry;
	If DocumentsPosting <> Undefined Then
		SubString = Table.Rows.Add();	
		SubString.Name = NStr("ru = 'Проведение документов'; SYS = 'AllFunctions.DocumentPostiong'", "ru");
		SubString.Form = "ExternalDataProcessor.StandardDocumentsPosting.Form";
		SubString.Picture = PictureLibForm;
		SubString.Type = "ExternalForm";
	EndIf;
	
	/////////////////////////////////////////////////////////////////////////////////
	If NeedControlTotals Then
		TotalsManagement = Undefined;
		Try
			TotalsManagement = New("ExternalDataProcessorObject.StandardTotalsManagement");
		Except
			Try
				ExternalDataProcessors.Connect("v8res://mngbase/StandardTotalsManagement.epf", "StandardTotalsManagement", false);
				TotalsManagement = New("ExternalDataProcessorObject.StandardTotalsManagement");
			Except
				//Message(ErrorDescription());
			EndTry;
		EndTry;
		If TotalsManagement <> Undefined Then
			SubString = Table.Rows.Add();	
			SubString.Name = NStr("ru = 'Управление итогами'; SYS = 'AllFunctions.TotalsManagement'", "ru");
			SubString.Form = "ExternalDataProcessor.StandardTotalsManagement.Form";
			SubString.Picture = PictureLibForm;
			SubString.Type = "ExternalForm";
		EndIf;
	EndIf;
    
	/////////////////////////////////////////////////////////////////////////////////
    // Работа со вншними источниками данных.
    ExternalDataSourcesManagementObjects = Undefined;
    Try
        ExternalDataSourcesManagementObjects = New("ExternalDataProcessorObject.StandardExternalDataSourcesManagement");
    Except
        Try
            ExternalDataProcessors.Connect("v8res://mngbase/StandardExternalDataSourcesManagement.epf", "StandardExternalDataSourcesManagement", false);
            ExternalDataSourcesManagementObjects = New("ExternalDataProcessorObject.StandardExternalDataSourcesManagement");
        Except
            //Message(ErrorDescription());
        EndTry;
    EndTry;
    If ExternalDataSourcesManagementObjects <> Undefined Then
        SubString = Table.Rows.Add();	
        SubString.Name = NStr("ru = 'Управление внешними источниками данных'; SYS = 'AllFunctions.StandardExternalDataSourcesManagement'", "ru");
        SubString.Form = "ExternalDataProcessor.StandardExternalDataSourcesManagement.Form";
        SubString.Picture = PictureLibForm;
        SubString.Type = "ExternalForm";
	EndIf;
	
	/////////////////////////////////////////////////////////////////////////////////
	If AccessRight("Administration", Metadata) 
		Or AccessRight("DataAdministration", Metadata) Then
		If Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_13
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_16
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_2
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_3
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_4
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_5
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_6
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_7
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_8
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_9
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_10
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_11
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_12
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_13 Then
			
			DatabaseCopiesManagementObjects = Undefined;
		    Try
		        DatabaseCopiesManagementObjects = New("ExternalDataProcessorObject.StandardDataBaseCopiesManagement");
		    Except
		        Try
		            ExternalDataProcessors.Connect("v8res://mngbase/StandardDataBaseCopiesManagement.epf", "StandardDataBaseCopiesManagement", false);
		            DatabaseCopiesManagementObjects = New("ExternalDataProcessorObject.StandardDataBaseCopiesManagement");
		        Except
		            //Message(ErrorDescription());
		        EndTry;
		    EndTry;
		    If DatabaseCopiesManagementObjects <> Undefined Then
		        SubString = Table.Rows.Add();	
		        SubString.Name = NStr("ru = 'Управление копиями базы данных'; SYS = 'AllFunctions.StandardDataBaseCopiesManagement'", "ru");
		        SubString.Form = "ExternalDataProcessor.StandardDataBaseCopiesManagement.Form";
		        SubString.Picture = PictureLibForm;
		        SubString.Type = "ExternalForm";
			EndIf;
		EndIf;
  EndIf;
  
  /////////////////////////////////////////////////////////////////////////////////
  If AccessRight("Administration", Metadata) Then
		If Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_13
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_16
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_1
			And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_2
      And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_3
      And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_4
      And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_5 Then
      
      AnalyticsSystemManagement = Undefined;
      Try
        AnalyticsSystemManagement = New("ExternalDataProcessorObject.StandardAnalyticsSystemManagement");
      Except
        Try
          ExternalDataProcessors.Connect("v8res://mngbase/StandardAnalyticsSystemManagement.epf", "StandardAnalyticsSystemManagement", false);
          AnalyticsSystemManagement = New("ExternalDataProcessorObject.StandardAnalyticsSystemManagement");
        Except
          //Message(ErrorDescription());
        EndTry;
      EndTry;
      If AnalyticsSystemManagement <> Undefined Then
        SubString = Table.Rows.Add();	
        SubString.Name = NStr("ru = 'Управление системой аналитики'; SYS = 'AllFunctions.AnalyticsSystemManagement'", "ru");
        SubString.Form = "ExternalDataProcessor.StandardAnalyticsSystemManagement.Form";
        SubString.Picture = PictureLibForm;
        SubString.Type = "ExternalForm";
      EndIf;
    EndIf;
	EndIf;
	
	/////////////////////////////////////////////////////////////////////////////////
	If AccessRight("ConfigurationExtensionsAdministration", Metadata) Then
		ExtensionsManagement = Undefined;
		Try
			ExtensionsManagement = New("ExternalDataProcessorObject.StandardExtensionsManagement");
		Except
			Try
				ExternalDataProcessors.Connect("v8res://mngbase/StandardExtensionsManagement.epf", "StandardExtensionsManagement", false);
				ExtensionsManagement = New("ExternalDataProcessorObject.StandardExtensionsManagement");
			Except
				//Message(ErrorDescription());
			EndTry;
		EndTry;
		If ExtensionsManagement <> Undefined Then
			SubString = Table.Rows.Add();	
			SubString.Name = NStr("ru = 'Управление расширениями конфигурации'; SYS = 'AllFunctions.ExtensionsManagement'", "ru");
			SubString.Form = "ExternalDataProcessor.StandardExtensionsManagement.Form";
			SubString.Picture = PictureLibForm;
			SubString.Type = "ExternalForm";
		EndIf;
	EndIf;
	
	/////////////////////////////////////////////////////////////////////////////////
	If AccessRight("CollaborationSystemInfoBaseRegistration", Metadata) AND
	   InfoBaseUsers.CurrentUser().Name <> ""
	Then
		ECSRegister = Undefined;
		Try
			ECSRegister = New("ExternalDataProcessorObject.StandardECSRegister");
		Except
			Try
				ExternalDataProcessors.Connect("v8res://mngbase/StandardECSRegister.epf", "StandardECSRegister", false);
				ECSRegister = New("ExternalDataProcessorObject.StandardECSRegister");
			Except
            	//Message(ErrorDescription());
			EndTry;
		EndTry;
		If ECSRegister <> Undefined Then
			SubString = Table.Rows.Add();	
			SubString.Name = NStr("ru = 'Управление системой взаимодействия'; SYS = 'AllFunctions.ColaborationSystemManagement'", "ru");
			SubString.Form = "ExternalDataProcessor.StandardECSRegister.Form";
			SubString.Picture = PictureLibForm;
			SubString.Type = "ExternalForm";
		EndIf;
	EndIf;
	
	/////////////////////////////////////////////////////////////////////////////////
	If AccessRight("Administration", Metadata) Then
		ServersControl = Undefined;
		Try
			ServersControl = New("ExternalDataProcessorObject.StandartServersControl");
		Except
			Try
				ExternalDataProcessors.Connect("v8res://mngbase/StandartServersControl.epf", "StandartServersControl", false);
				ServersControl = New("ExternalDataProcessorObject.StandartServersControl");
			Except
            	//Message(ErrorDescription());
			EndTry;
		EndTry;
		If ServersControl <> Undefined Then
			SubString = Table.Rows.Add();	
			SubString.Name = NStr("ru = 'Управление серверами'; SYS = 'AllFunctions.ServersControl'", "ru");
			SubString.Form = "ExternalDataProcessor.StandartServersControl.Form";
			SubString.Picture = PictureLibForm;
			SubString.Type = "ExternalForm";
		EndIf;
	EndIf;

	/////////////////////////////////////////////////////////////////////////////////
	If Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_1
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_13
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_2_16
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_1
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_2
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_3
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_4
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_5
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_6
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_7
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_8
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_9
		And Metadata.CompatibilityMode <> Metadata.ObjectProperties.CompatibilityMode.Version8_3_10 Then
			
		StandardDataChangeHistory = Undefined;
		Try
			StandardDataChangeHistory = New("ExternalDataProcessorObject.StandardDataChangeHistory");
		Except
			Try
				ExternalDataProcessors.Connect("v8res://mngbase/StandardDataChangeHistory.epf", "StandardDataChangeHistory", false);
				StandardDataChangeHistory = New("ExternalDataProcessorObject.StandardDataChangeHistory");
			Except
	        	//Message(ErrorDescription());
			EndTry;
		EndTry;
		If StandardDataChangeHistory <> Undefined Then
			SubString = Table.Rows.Add();	
			SubString.Name = NStr("ru = 'История изменений данных'; SYS = 'AllFunctions.DataChangeHistory'", "ru");
			SubString.Form = "ExternalDataProcessor.StandardDataChangeHistory.Form";
			SubString.Picture = PictureLibForm;
			SubString.Type = "ExternalForm";
		EndIf;

			
	EndIf;
	
	/////////////////////////////////////////////////////////////////////////////////
	If AccessRight("DataAdministration", Metadata) Then	
		ErrorProcessingSettings = Undefined;
		Try
			ErrorProcessingSettings = New("ExternalDataProcessorObject.StandardErrorProcessingSettings");
		Except
			Try
				ExternalDataProcessors.Connect("v8res://mngbase/StandardErrorProcessingSettings.epf", "StandardErrorProcessingSettings", false);
				ErrorProcessingSettings = New("ExternalDataProcessorObject.StandardErrorProcessingSettings");
			Except
            	//Message(ErrorDescription());
			EndTry;
		EndTry;
		If ErrorProcessingSettings <> Undefined Then
			SubString = Table.Rows.Add();	
			SubString.Name = NStr("ru = 'Управление настройками обработки ошибок'; SYS = 'AllFunctions.StandardErrorProcessingSettings'", "ru");
			SubString.Form = "ExternalDataProcessor.StandardErrorProcessingSettings.Form";
			SubString.Picture = PictureLibForm;
			SubString.Type = "ExternalForm";
		EndIf;
	EndIf;
	
	/////////////////////////////////////////////////////////////////////////////////
	If  AccessRight("Administration", Metadata) 
		Or AccessRight("DataAdministration", Metadata) Then	
		StandardIntegrationServicesManagment = Undefined;
		Try
			StandardIntegrationServicesManagment = New("ExternalDataProcessorObject.StandardIntegrationServicesManagment");
		Except
			Try
				ExternalDataProcessors.Connect("v8res://mngbase/StandardIntegrationServicesManagment.epf", "StandardIntegrationServicesManagment", false);
				StandardIntegrationServicesManagment = New("ExternalDataProcessorObject.StandardIntegrationServicesManagment");
			Except
            	//Message(ErrorDescription());
			EndTry;
		EndTry;
		If StandardIntegrationServicesManagment <> Undefined Then
			SubString = Table.Rows.Add();	
			SubString.Name = NStr("ru = 'Управление сервисами интеграции'; SYS = 'AllFunctions.StandardIntegrationServicesManagment'", "ru");
			SubString.Form = "ExternalDataProcessor.StandardIntegrationServicesManagment.Form";
			SubString.Picture = PictureLibForm;
			SubString.Type = "ExternalForm";
		EndIf;
	EndIf;
	
	FillTree(Row, Table.Rows);
	
	Дерево = РеквизитФормыВЗначение("MetadataTree", ТИП("ДеревоЗначений"));
	УстановитьПривилегированныйРежим(Истина);
	ХранилищеОбщихНастроек.Сохранить("ВсеФункцииПлюс", "ДеревоКЭШ", Дерево,,"ВсеПользователи");
	УстановитьПривилегированныйРежим(Ложь);

КонецПроцедуры

&НаСервере
Функция ПолучитьЗначениеИзОбщихНастроек(ИмяЗначения, LanguageCode) 
	
	УстановитьПривилегированныйРежим(Истина);
	Результат = ХранилищеОбщихНастроек.Загрузить("СтандартныеФункции", ИмяЗначения,, "ВсеПользователи");
	Если Результат = Неопределено Тогда
		Try
			ExternalDataProcessors.Connect("v8res://mngbase/"+ИмяЗначения+".epf", ИмяЗначения, false, , LanguageCode);
			Результат = true;
		Except
			Результат = false;
		EndTry;
		ХранилищеОбщихНастроек.Сохранить("СтандартныеФункции", ИмяЗначения, Результат,, "ВсеПользователи");
	КонецЕсли;
	УстановитьПривилегированныйРежим(Ложь); 
	
	Возврат Результат;

КонецФункции