CREATE TABLE `User` (
`User_ID` int(11) NOT NULL,
`User_loginName` varchar(255) NOT NULL,
`User_password` varchar(255) NOT NULL,
`Role_ID` int(11) NOT NULL,
`User_Name` varchar(255) NOT NULL,
`Department_ID` int(11) NOT NULL,
PRIMARY KEY (`User_ID`) 
);
CREATE TABLE `Role` (
`Role_ID` int(11) NOT NULL,
`Function_id` int(11) NOT NULL,
`Role_Name` varchar(255) NOT NULL COMMENT '职称',
PRIMARY KEY (`Role_ID`) 
);
CREATE TABLE `Department` (
`Department_ID` int(11) NOT NULL,
`Department_Code` varchar(255) NOT NULL,
`Department_Name` varchar(255) NOT NULL,
`Department_Type` varchar(255) NOT NULL COMMENT '1-临床 2-医技 3-财务 4-行政 5-其它',
`Department_CategoryID` int(2) NOT NULL,
PRIMARY KEY (`Department_ID`) 
);
CREATE TABLE `Function` (
`Function_ID` int(11) NOT NULL,
`Role_ID` int(11) NULL,
`Function_URL` varchar(255) NOT NULL,
`Function_Name` varchar(255) NOT NULL,
`Father_Function_ID` int(11) NULL COMMENT '子菜单指向父菜单，无需指向Role',
PRIMARY KEY (`Function_ID`) 
);
CREATE TABLE `Scheduling` (
`Scheduling_ID` varchar(255) NOT NULL,
`Doctor_ID` int(11) NOT NULL,
`Scheduling_NoonBreak` char(2) NOT NULL,
`Scheduling_StartTime` int(5) NOT NULL,
`Scheduling_EndTime` int(5) NOT NULL,
`Scheduling_Weekday` varchar(255) NOT NULL,
`Scheduling_LimitCount` int(2) NOT NULL,
`Scheduling_RestCount` int(2) NOT NULL,
PRIMARY KEY (`Scheduling_ID`) 
);
CREATE TABLE `Day_Cal` (
`Day_Cal_ID` int(11) NOT NULL,
`User_ID` int(11) NOT NULL,
`Day_Cal_StartDate` date NOT NULL,
`Day_Cal_EndDate` date NOT NULL,
`Day_Cal_Total` varchar(255) NOT NULL,
PRIMARY KEY (`Day_Cal_ID`) 
);
CREATE TABLE `Registration` (
`Registration_ID` int(11) NOT NULL,
`Medical_Record_ID` int NOT NULL,
`Registration_Level_ID` varchar(255) NOT NULL,
`Patient_ID` int(11) NOT NULL,
`Department_ID` int(11) NOT NULL,
`Calculation_Category_ID` int(11) NOT NULL,
`Doctor_ID` int(11) NULL,
`Registration_Date` date NOT NULL,
`Have_Medical_Record` int(2) NULL,
`Registration_Total_Cost` decimal(10,2) NOT NULL,
`Expense_Class_ID` int(11) NOT NULL,
`Expense_Items_ID` int(11) NOT NULL,
`Registration_Status` int(2) NOT NULL COMMENT '挂号状态:0 未看诊;1 已看诊;2 诊毕;3 退号;',
PRIMARY KEY (`Registration_ID`) 
);
CREATE TABLE `Medical_Record` (
`Medical_Record_ID` int(11) NOT NULL,
`Is_Treament_Over` int(2) NOT NULL,
PRIMARY KEY (`Medical_Record_ID`) 
);
CREATE TABLE `Expense_Items` (
`Expense_Items_ID` int(11) NOT NULL,
`Medical_Record_ID` int(11) NOT NULL,
`Total_Cost` decimal(10,2) NOT NULL,
`Pay_Status` int(2) NOT NULL COMMENT '收费状态:0 未收费;1 未消费;2 已消费;3 退费;',
`Is_Day_Cal` varchar(255) NOT NULL,
`Pay_Date` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
`Invoice_NO` int(11) NULL COMMENT '交费后，打印发票并生成发票号。退费时根据发票号确定退费项目是什么。\r\n发票上项目全部退掉，重打剩余部分。\r\n或者退掉部分。',
PRIMARY KEY (`Expense_Items_ID`) 
);
CREATE TABLE `Registration_Level` (
`Registration_Level_ID` int(11) NOT NULL,
`Registration_Level_Name` varchar(255) NULL,
`Is_Default` varchar(255) NULL,
`Registration_Cost` decimal(10,2) NULL,
PRIMARY KEY (`Registration_Level_ID`) 
);
CREATE TABLE `Calculation_Category` (
`Calculation_Category_ID` int(11) NOT NULL,
`Calculation_Category` varchar(255) NULL,
PRIMARY KEY (`Calculation_Category_ID`) 
);
CREATE TABLE `Disease` (
`Disease_ID` int(11) NOT NULL,
`Disease_Name` varchar(255) NOT NULL,
`Disease_Code` varchar(255) NOT NULL,
`Disease_ICD` varchar(255) NOT NULL,
`Disease_Category_ID` int(11) NOT NULL,
`Disease_Customize_Name1` varchar(255) NULL,
`Disease_Customize_Name2` varchar(255) NULL,
PRIMARY KEY (`Disease_ID`) 
);
CREATE TABLE `Disease_Category` (
`Disease_Category_ID` int(11) NOT NULL,
`Disease_Category_Code` varchar(255) NOT NULL,
`Disease_Category_Name` varchar(255) NOT NULL,
`Disease_Category_Type` varchar(255) NOT NULL COMMENT '疾病类别:1 西医疾病;2 中医疾病;',
PRIMARY KEY (`Disease_Category_ID`) 
);
CREATE TABLE `Patient` (
`Patient_ID` int(11) NOT NULL,
`Patient_Name` varchar(255) NOT NULL,
`Patient_Gender` char(2) NOT NULL,
`Patient_Birth` varchar(255) NOT NULL,
`Patient_Age` int(2) NULL,
`Patient_IDentity` varchar(255) NOT NULL,
`Patient_Address` varchar(255) NULL,
PRIMARY KEY (`Patient_ID`) 
);
CREATE TABLE `Expense_Class` (
`Expense_Class_ID` int(11) NOT NULL,
`Expense_Class_Code` varchar(255) NULL,
`Expense_Class_Name` varchar(255) NULL,
PRIMARY KEY (`Expense_Class_ID`) 
);
CREATE TABLE `Fmedical_Items` (
`Fmedical_Items_ID` int(11) NOT NULL,
`Fmedical_Items_Code` varchar(255) NULL,
`Fmedical_Items_Name` varchar(255) NULL,
`Fmedical_Items_Format` varchar(255) NULL,
`Fmedical_Items_Price` decimal(10,2) NULL,
`Fmedical_Items_MnemonicCode` varchar(255) NULL COMMENT '拼音助记码',
`Fmedical_Items_Type` varchar(255) NULL,
`Department_ID` int(11) NULL,
`Expense_Class_ID` int(11) NULL,
PRIMARY KEY (`Fmedical_Items_ID`) 
);
CREATE TABLE `Medical_Record_Home_Page` (
`Medical_Record_Home_Page_ID` int(11) NOT NULL COMMENT '病历首页',
`Medical_Redical_ID` int(11) NULL COMMENT '病历ID',
`Doctor_ID` int(11) NULL COMMENT '医生ID',
`Chief_Complaint` varchar(255) NULL COMMENT '主诉：病人对自我感觉最痛苦的病情的简要叙述',
`Present_History` varchar(255) NULL COMMENT '现病史',
`Present_Treatment` varchar(255) NULL COMMENT '现病治疗情况',
`Past_History` varchar(255) NULL COMMENT '现病史',
`Allergic_History` varchar(255) NULL COMMENT '过敏史',
`Physical_Examination` varchar(255) NULL COMMENT '体格检查',
PRIMARY KEY (`Medical_Record_Home_Page_ID`) 
);
CREATE TABLE `Diagnosis` (
`Diagnosis_ID` int(11) NOT NULL COMMENT '诊断ID',
`Disease_ID` int(11) NULL COMMENT '疾病ID',
`Medical_Record_ID` int(11) NULL COMMENT '病历ID',
`Main_Diagnosis_Mark` char(1) NULL COMMENT '主诊标志 0 非主诊 1 主诊',
`Suspect_Mark` char(1) NULL COMMENT '疑似标志 0 确认 1 疑似',
`Onset_Date` date NULL COMMENT '发病日期',
`Diagnosis_Mark` char(1) NULL COMMENT '诊断标志 0初诊 1终诊',
PRIMARY KEY (`Diagnosis_ID`) 
);
CREATE TABLE `Prescription` (
`Prescription_ID` int(11) NOT NULL,
`Medical_Record_ID` int(11) NULL COMMENT '病历id',
`Doctor_ID` int(11) NULL COMMENT '医生id',
`Submit_Time` timestamp NULL COMMENT '开立时间',
`Prescription_Type` char(1) NULL COMMENT '处方类型：草药或者成药',
PRIMARY KEY (`Prescription_ID`) 
);
CREATE TABLE `Prescription_Items` (
`id` int(11) NOT NULL COMMENT '处方条目ID',
`Prescription_ID` int(11) NULL COMMENT '成药处方id',
`Drags_ID` int(11) NULL COMMENT '药品id',
`Expense_Items_ID` int(11) NULL COMMENT '收费ID',
`Usage` char(2) NULL COMMENT '用法：01 静脉滴注 02 静脉可注 03 肌肉注射 04 口服 05 皮试 06 皮下注射',
`Dosage` decimal(11,2) NULL COMMENT '用量',
`Times` int(11) NULL COMMENT '频次',
`Days` int(11) NULL COMMENT '天数 （与频次组合 得到*天*次 如1天3次）',
`Quantity` int(11) NULL COMMENT '数量',
`Drugs_Advice` varchar(255) NULL COMMENT '用药嘱托',
`Drugs_Dispensing_Status` char(1) NULL COMMENT '发药状态：0 未发药 1 已发药',
PRIMARY KEY (`id`) 
);
CREATE TABLE `Drugs` (
`Drugs_ID` int(11) NOT NULL COMMENT '药品ID',
`Drugs_Code` varchar(255) NULL COMMENT '药品编码',
`Drugs_Name` varchar(255) NULL COMMENT '药品名称',
`Drugs_Specification` varchar(255) NULL COMMENT '药品规格',
`Drugs_Packaging_Unit` varchar(255) NULL COMMENT '包装单位',
`Drugs_Manufacturer` varchar(255) NULL COMMENT '生产厂家',
`Drugs_Dosage_Form` varchar(255) NULL COMMENT '药品剂型',
`Drugs_Type` varchar(255) NULL COMMENT '药品类型',
`Drugs_Price` decimal(11,2) NULL COMMENT '药品单价',
`Drugs_MnemonicCode` varchar(255) NULL COMMENT '拼音助记码',
PRIMARY KEY (`Drugs_ID`) 
);
CREATE TABLE `Group_Prescription` (
`Group_Prescription_ID` int(11) NOT NULL COMMENT '处方组套ID',
`Doctor_ID` int(11) NULL COMMENT '医生ID',
`Group_Prescription_Code` varchar(255) NULL COMMENT '组合编码',
`Group_Prescription_Name` varchar(255) NULL COMMENT '组合名称',
`Group_Prescription_Scope` char(2) NULL COMMENT '适用范围：01 个人 02 科室 03 全院',
`Create_Time` timestamp NULL COMMENT '创建时间',
`Prescription_Class` char(1) NULL COMMENT '处方类型：0 成药处方 1 草药处方',
PRIMARY KEY (`Group_Prescription_ID`) 
);
CREATE TABLE `Commonly_Used_Drugs` (
`Commonly_Used_Drugs` int(11) NOT NULL COMMENT '常用药品ID',
`Doctor_ID` int(11) NULL COMMENT '医生ID',
`Drugs_ID` int(11) NULL COMMENT '药品ID',
PRIMARY KEY (`Commonly_Used_Drugs`) 
);
CREATE TABLE `Medical_Record_Home_Page_Template` (
`Medical_Record_Home_Page_Template_ID` int(11) NOT NULL COMMENT '病历首页模板ID',
`Doctor_ID` int(11) NULL,
`Name` varchar(255) NULL COMMENT '模板名称',
`Scope` char(2) NULL COMMENT '使用范围：01 个人 02 科室 03 全院',
`Chief_Complaint` varchar(255) NULL,
`Present_History` varchar(255) NULL,
`Physical_Examination` varchar(255) NULL,
PRIMARY KEY (`Medical_Record_Home_Page_Template_ID`) 
);
CREATE TABLE `Examination` (
`Examination_ID` int(11) NOT NULL COMMENT '检查检验ID',
`Medical_Record` int(11) NULL COMMENT '病历ID',
`Doctor_ID` int(11) NULL COMMENT '医生ID',
`Examination_Mark` char(1) NULL COMMENT '检查检验标志：0 检查 1 检验',
`Doctor_Advice` varchar(255) NULL COMMENT '医生嘱托',
`Submit_Time` timestamp NULL COMMENT '申请时间',
PRIMARY KEY (`Examination_ID`) 
);
CREATE TABLE `Examination_Fmedical_Items` (
`Examination_Items_ID` int(11) NOT NULL COMMENT '非药品检查检验明细ID',
`Examination_ID` int(11) NULL COMMENT '检查检验ID',
`Fmedical_Items_ID` int(11) NULL COMMENT '非药品ID',
`Registration_Status` char(1) NULL COMMENT '登记状态：0 未登记 1 已登记',
`Purpose_Requirements` varchar(255) NULL COMMENT '目的和要求',
`Quantity` decimal(11,2) NULL COMMENT '数量',
`Examination_Result_ID` int(11) NULL COMMENT '检查检验结果ID',
`Expense_Items_ID` int(11) NULL COMMENT '收费ID',
PRIMARY KEY (`Examination_Items_ID`) 
);
CREATE TABLE `Examination_Result` (
`Examination_Result_ID` int(11) NOT NULL COMMENT '检查检验结果ID',
`Doctor_ID` int(11) NULL COMMENT '医生ID',
`Findings` varchar(255) NULL COMMENT '检查\\检验所见',
`Diagnostic_Suggestion` varchar(255) NULL COMMENT '诊断意见',
`Submit_Time` varchar(255) NULL COMMENT '时间',
PRIMARY KEY (`Examination_Result_ID`) 
);
CREATE TABLE `Examination_Result_Image` (
`Examination_Result_Image_ID` int(11) NOT NULL COMMENT '检查检验图片ID',
`Examination_Result_ID` int(11) NULL COMMENT '检查检验结果ID',
`Image_URL` varchar(255) NULL COMMENT '图片url',
`Image_Name` varchar(255) NULL COMMENT '图片名称',
PRIMARY KEY (`Examination_Result_Image_ID`) 
);
CREATE TABLE `Group_Examination` (
`Group_Examination_ID` int(11) NOT NULL COMMENT '检查检验组套ID',
`Doctor_ID` int(11) NULL COMMENT '创建医生ID',
`Group_Examination_Code` varchar(255) NULL COMMENT '组套编码',
`Group_Examination_Name` varchar(255) NULL COMMENT '组套ID',
`Group_Examination_Scope` char(2) NULL COMMENT '适用范围 ：01 个人 02 科室 03 全院',
`Create_Time` timestamp NULL COMMENT '创建时间',
PRIMARY KEY (`Group_Examination_ID`) 
);
CREATE TABLE `Commonly_Used_Fmedical` (
`Commonly_Used_Fmedical_ID` int(11) NOT NULL COMMENT '常用非药品项目ID',
`Doctor_ID` int(11) NULL COMMENT '医生ID',
`Fmedical_Items_ID` int(11) NULL COMMENT '非药品收费项目ID',
PRIMARY KEY (`Commonly_Used_Fmedical_ID`) 
);
CREATE TABLE `Treatment` (
`Treatment_ID` int(11) NOT NULL COMMENT '处置ID',
`Medical_Record_ID` int(11) NULL COMMENT '病历号ID',
`Doctor_ID` int(11) NULL COMMENT '医生ID',
`Submit_Time` timestamp NULL COMMENT '提交时间',
PRIMARY KEY (`Treatment_ID`) 
);
CREATE TABLE `Treatment_Items` (
`Treatment_Items_ID` int(11) NOT NULL COMMENT 'id',
`Treatment_ID` int(11) NULL COMMENT '处置id',
`Fmedical_Items_ID` int(11) NULL COMMENT '非药品目录id',
`Quantity` int(11) NULL COMMENT '数量',
`Expense_Items_ID` int(11) NULL COMMENT '费用明细ID',
PRIMARY KEY (`Treatment_Items_ID`) 
);
CREATE TABLE `Group_Treatment_Items` (
`Group_Treatment_Items_ID` int(11) NOT NULL COMMENT '处置组套明细ID',
`Group_Treatment_ID` int(11) NULL COMMENT '处置组套ID',
`Fmedical_Items_ID` int(11) NULL COMMENT '非药品项目ID',
`Quantity` int(11) NULL COMMENT '数量',
`Group_Treatment_Scope` varchar(255) NULL COMMENT '适用范围 01 个人 02 科室 03 全院',
PRIMARY KEY (`Group_Treatment_Items_ID`) 
);
CREATE TABLE `Group_Treatment` (
`Group_Treatment_ID` int(11) NOT NULL COMMENT '创建医生',
`Doctor_ID` int(11) NULL COMMENT '创建医生ID',
`Group_Treatment_Code` varchar(255) NULL COMMENT '组合代码',
`Group_Treatment_Name` varchar(255) NULL COMMENT '组合名称',
`Group_Treatment_Scope` char(2) NULL COMMENT '适用范围 ：01 个人 02 科室 03 全院',
`Create_Time` timestamp NULL COMMENT '创建时间',
PRIMARY KEY (`Group_Treatment_ID`) 
);
CREATE TABLE `Commonly_Used_Diagnosis` (
`Commonly_Used_Diagnosis_ID` int(11) NOT NULL COMMENT '常用诊断ID',
`Doctor_ID` int(11) NULL COMMENT '医生ID',
`Disease_ID` int(11) NULL COMMENT '疾病ID',
PRIMARY KEY (`Commonly_Used_Diagnosis_ID`) 
);
CREATE TABLE `Group_Prescription_Items` (
`Group_Prescription_Items_ID` int(11) NOT NULL COMMENT '处方条目ID',
`Group_Prescription_ID` int(11) NULL COMMENT '成药处方组套ID',
`Drags_ID` int(11) NULL COMMENT '药品ID',
`Usage` char(2) NULL COMMENT '用法：01 静脉滴注 02 静脉可注 03 肌肉注射 04 口服 05 皮试 06 皮下注射',
`Dosage` decimal(11,2) NULL COMMENT '用量',
`Times` int(11) NULL COMMENT '频次',
`Days` int(11) NULL COMMENT '天数 （与频次组合 得到*天*次 如1天3次）',
`Quantity` int(11) NULL COMMENT '数量',
`Drugs_Advice` varchar(255) NULL COMMENT '用药嘱托',
PRIMARY KEY (`Group_Prescription_Items_ID`) 
);
CREATE TABLE `Examination_Drugs_Items` (
`Examination_Drugs_ID` int(11) NOT NULL COMMENT 'id',
`Examination_Fmedical_Items_ID` int(11) NULL COMMENT '检查检验 非药品明细ID',
`Drugs_ID` int(11) NULL COMMENT '药品id',
`Usage` char(2) NULL COMMENT '用法',
`Quantity` int(11) NULL COMMENT '数量',
`Drugs_Dispensing_Status` char(1) NULL COMMENT '发药状态 ：0 未发药 1 已发药',
`Expense_Items_ID` int(11) NULL COMMENT '收费ID',
`Doctor_ID` int(11) NULL,
PRIMARY KEY (`Examination_Drugs_ID`) 
);
CREATE TABLE `检查检验组套药品明细` (
`id` int(11) NOT NULL,
`检查检验模板ID` int(11) NULL,
`药品id` int(11) NULL,
`用法` char(2) NULL,
`数量` int(11) NULL,
PRIMARY KEY (`id`) 
);
CREATE TABLE `Group_Examination_Drugs_Items` (
`Group_Examination_Drugs_ID` int(11) NOT NULL COMMENT 'id',
`Group_Examination_Fmedical_Items_ID` int(11) NULL COMMENT '检查检验 非药品模板明细ID',
`Drugs_ID` int(11) NULL COMMENT '药品id',
`Usage` char(2) NULL COMMENT '用法',
`Quantity` int(11) NULL COMMENT '数量',
PRIMARY KEY (`Group_Examination_Drugs_ID`) 
);
CREATE TABLE `Group_Examination_Fmedical_Items` (
`Group_Examination_Fmedical_Items_ID` int(11) NOT NULL COMMENT '非药品检查检验组套明细ID',
`Group_Examination_ID` int(11) NULL COMMENT '检查检验组套ID',
`Fmedical_Items_ID` int(11) NULL COMMENT '非药品ID',
`Purpose_Requirements` varchar(255) NULL COMMENT '目的和要求',
`Quantity` decimal(11,2) NULL COMMENT '数量',
PRIMARY KEY (`Group_Examination_Fmedical_Items_ID`) 
);
CREATE TABLE `Diagnosis_Template` (
`Diagnosis_Template_ID` int(11) NOT NULL COMMENT '诊断模板ID',
`Medical_Record_Home_Page_Template_ID` int(11) NULL COMMENT '病历首页模板ID',
`Disease_ID` int(11) NULL COMMENT '疾病ID',
`Main_Diagnosis_Mark` char(1) NULL COMMENT '主诊标志 0 非主诊 1 主诊',
`Suspect_Mark` char(1) NULL COMMENT '疑似标志 0 确认 1 疑似',
PRIMARY KEY (`Diagnosis_Template_ID`) 
);
CREATE TABLE `Constant_Items` (
`Constant_Items_ID` int(11) NOT NULL,
`Constant_Items_Name` varchar(255) NOT NULL,
`Constant_Items_Code` varchar(255) NOT NULL,
`Constant_Type_ID` int(11) NOT NULL,
PRIMARY KEY (`Constant_Items_ID`) 
);
CREATE TABLE `Constant_Type` (
`Constant_Type_ID` int(11) NOT NULL,
`Constant_Type_Name` varchar(255) NOT NULL,
`Constant_Type_Code` varchar(255) NOT NULL,
PRIMARY KEY (`Constant_Type_ID`) 
);
CREATE TABLE `Scheduling_Info` (
`Scheduling_ID` varchar(255) NOT NULL,
`Doctor_ID` int(11) NOT NULL,
`Scheduling_NoonBreak` char(2) NOT NULL,
`Scheduling_StartTime` int(5) NOT NULL,
`Scheduling_EndTime` int(5) NOT NULL,
`Scheduling_Weekday` varchar(255) NOT NULL,
`Scheduling_LimitCount` int(2) NOT NULL,
`Scheduling_RestCount` int(2) NOT NULL,
`Scheduling_Date` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (`Scheduling_ID`) 
);
CREATE TABLE `Scheduling_Rule` (
`Scheduling_Rule_ID` int(11) NOT NULL,
`Doctor_ID` int(11) NULL,
`Scheduling_Rule_NoonBreak` varchar(255) NULL,
`Scheduling_Rule_StartTime` datetime NULL ON UPDATE CURRENT_TIMESTAMP,
`Scheduling_Rule_EndTime` datetime NULL ON UPDATE CURRENT_TIMESTAMP,
`Scheduling_Rule_Weekday` varchar(255) NULL,
`Scheduling_Rule_LimitCount` varchar(255) NULL,
PRIMARY KEY (`Scheduling_Rule_ID`) 
);

ALTER TABLE `Department` ADD CONSTRAINT `fk_Department_User_1` FOREIGN KEY (`Department_ID`) REFERENCES `User` (`Department_ID`);
ALTER TABLE `User` ADD CONSTRAINT `fk_User_Role_1` FOREIGN KEY (`Role_ID`) REFERENCES `Role` (`Role_ID`);
ALTER TABLE `Function` ADD CONSTRAINT `fk_Function_Role_1` FOREIGN KEY (`Role_ID`) REFERENCES `Role` (`Role_ID`);
ALTER TABLE `Function` ADD CONSTRAINT `fk_Function_Function_1` FOREIGN KEY (`Father_Function_ID`) REFERENCES `Function` (`Function_ID`);
ALTER TABLE `Scheduling` ADD CONSTRAINT `fk_Scheduling_User_1` FOREIGN KEY (`Doctor_ID`) REFERENCES `User` (`User_ID`);
ALTER TABLE `Day_Cal` ADD CONSTRAINT `fk_Day_Cal_User_1` FOREIGN KEY (`User_ID`) REFERENCES `User` (`User_ID`);
ALTER TABLE `Expense_Items` ADD CONSTRAINT `fk_Expense_Items_Medical_Record_1` FOREIGN KEY (`Medical_Record_ID`) REFERENCES `Medical_Record` (`Medical_Record_ID`);
ALTER TABLE `Registration` ADD CONSTRAINT `fk_Registration_Medical_Record_1` FOREIGN KEY (`Medical_Record_ID`) REFERENCES `Medical_Record` (`Medical_Record_ID`);
ALTER TABLE `Registration` ADD CONSTRAINT `fk_Registration_Registration_Level_1` FOREIGN KEY (`Registration_Level_ID`) REFERENCES `Registration_Level` (`Registration_Level_ID`);
ALTER TABLE `Registration` ADD CONSTRAINT `fk_Registration_Calculation_Category_1` FOREIGN KEY (`Calculation_Category_ID`) REFERENCES `Calculation_Category` (`Calculation_Category_ID`);
ALTER TABLE `Registration` ADD CONSTRAINT `fk_Registration_Patient_1` FOREIGN KEY (`Patient_ID`) REFERENCES `Patient` (`Patient_ID`);
ALTER TABLE `Expense_Class` ADD CONSTRAINT `fk_Expense_Class_Registration_1` FOREIGN KEY (`Expense_Class_ID`) REFERENCES `Registration` (`Expense_Class_ID`);
ALTER TABLE `Registration` ADD CONSTRAINT `fk_Registration_Expense_Items_1` FOREIGN KEY (`Expense_Items_ID`) REFERENCES `Expense_Items` (`Expense_Items_ID`);
ALTER TABLE `Disease` ADD CONSTRAINT `fk_Disease_Disease_Category_1` FOREIGN KEY (`Disease_Category_ID`) REFERENCES `Disease_Category` (`Disease_Category_ID`);
ALTER TABLE `Fmedical_Items` ADD CONSTRAINT `fk_Treatment_Items_Expense_Class_1` FOREIGN KEY (`Expense_Class_ID`) REFERENCES `Expense_Class` (`Expense_Class_ID`);
ALTER TABLE `Fmedical_Items` ADD CONSTRAINT `fk_Treatment_Items_Department_1` FOREIGN KEY (`Department_ID`) REFERENCES `Department` (`Department_ID`);
ALTER TABLE `Medical_Record_Home_Page` ADD CONSTRAINT `fk_病历首页_Medical_Record_1` FOREIGN KEY (`Medical_Redical_ID`) REFERENCES `Medical_Record` (`Medical_Record_ID`);
ALTER TABLE `User` ADD CONSTRAINT `fk_User_病历首页_1` FOREIGN KEY (`User_ID`) REFERENCES `Medical_Record_Home_Page` (`Doctor_ID`);
ALTER TABLE `Diagnosis` ADD CONSTRAINT `fk_诊断_Disease_1` FOREIGN KEY (`Disease_ID`) REFERENCES `Disease` (`Disease_ID`);
ALTER TABLE `Diagnosis` ADD CONSTRAINT `fk_诊断_Medical_Record_1` FOREIGN KEY (`Medical_Record_ID`) REFERENCES `Medical_Record` (`Medical_Record_ID`);
ALTER TABLE `Prescription_Items` ADD CONSTRAINT `fk_成药处方明细_成药处方明细_1` FOREIGN KEY (`Prescription_ID`) REFERENCES `Prescription` (`Prescription_ID`);
ALTER TABLE `Drugs` ADD CONSTRAINT `fk_药品收费项目表_成药处方明细_1` FOREIGN KEY (`Drugs_ID`) REFERENCES `Prescription_Items` (`Drags_ID`);
ALTER TABLE `Commonly_Used_Drugs` ADD CONSTRAINT `fk_常用药品_药品收费项目表_1` FOREIGN KEY (`Drugs_ID`) REFERENCES `Drugs` (`Drugs_ID`);
ALTER TABLE `Prescription` ADD CONSTRAINT `fk_成药处方_Medical_Record_1` FOREIGN KEY (`Medical_Record_ID`) REFERENCES `Medical_Record` (`Medical_Record_ID`);
ALTER TABLE `Prescription` ADD CONSTRAINT `fk_成药处方_User_1` FOREIGN KEY (`Doctor_ID`) REFERENCES `User` (`User_ID`);
ALTER TABLE `Commonly_Used_Drugs` ADD CONSTRAINT `fk_常用药品_User_1` FOREIGN KEY (`Doctor_ID`) REFERENCES `User` (`User_ID`);
ALTER TABLE `Group_Prescription` ADD CONSTRAINT `fk_处方组套_User_1` FOREIGN KEY (`Doctor_ID`) REFERENCES `User` (`User_ID`);
ALTER TABLE `Examination_Fmedical_Items` ADD CONSTRAINT `fk_检查检验明细_检查检验明细_1` FOREIGN KEY (`Examination_ID`) REFERENCES `Examination` (`Examination_ID`);
ALTER TABLE `Examination_Result_Image` ADD CONSTRAINT `fk_检查检验结果图像_检查检验结果图像_1` FOREIGN KEY (`Examination_Result_ID`) REFERENCES `Examination_Result` (`Examination_Result_ID`);
ALTER TABLE `Examination_Result` ADD CONSTRAINT `fk_检查检验结果_User_1` FOREIGN KEY (`Doctor_ID`) REFERENCES `User` (`User_ID`);
ALTER TABLE `Examination` ADD CONSTRAINT `fk_检查检验_Medical_Record_1` FOREIGN KEY (`Medical_Record`) REFERENCES `Medical_Record` (`Medical_Record_ID`);
ALTER TABLE `Examination` ADD CONSTRAINT `fk_检查检验_User_1` FOREIGN KEY (`Doctor_ID`) REFERENCES `User` (`User_ID`);
ALTER TABLE `Examination_Fmedical_Items` ADD CONSTRAINT `fk_检查检验明细_Treatment_Items_1` FOREIGN KEY (`Fmedical_Items_ID`) REFERENCES `Fmedical_Items` (`Fmedical_Items_ID`);
ALTER TABLE `Group_Examination` ADD CONSTRAINT `fk_检查检验组套_User_1` FOREIGN KEY (`Doctor_ID`) REFERENCES `User` (`User_ID`);
ALTER TABLE `Commonly_Used_Fmedical` ADD CONSTRAINT `fk_常用项目_User_1` FOREIGN KEY (`Doctor_ID`) REFERENCES `User` (`User_ID`);
ALTER TABLE `Commonly_Used_Fmedical` ADD CONSTRAINT `fk_常用项目_Treatment_Items_1` FOREIGN KEY (`Fmedical_Items_ID`) REFERENCES `Fmedical_Items` (`Fmedical_Items_ID`);
ALTER TABLE `Treatment_Items` ADD CONSTRAINT `fk_处置明细_Treatment_Items_1` FOREIGN KEY (`Fmedical_Items_ID`) REFERENCES `Fmedical_Items` (`Fmedical_Items_ID`);
ALTER TABLE `Treatment_Items` ADD CONSTRAINT `fk_处置明细_处置_1` FOREIGN KEY (`Treatment_ID`) REFERENCES `Treatment` (`Treatment_ID`);
ALTER TABLE `Group_Treatment_Items` ADD CONSTRAINT `fk_处置组套明细_Treatment_Items_1` FOREIGN KEY (`Fmedical_Items_ID`) REFERENCES `Fmedical_Items` (`Fmedical_Items_ID`);
ALTER TABLE `Group_Treatment_Items` ADD CONSTRAINT `fk_处置组套明细_处置组套_1` FOREIGN KEY (`Group_Treatment_ID`) REFERENCES `Group_Treatment` (`Group_Treatment_ID`);
ALTER TABLE `Group_Treatment` ADD CONSTRAINT `fk_处置组套_User_1` FOREIGN KEY (`Doctor_ID`) REFERENCES `User` (`User_ID`);
ALTER TABLE `Treatment` ADD CONSTRAINT `fk_处置_User_1` FOREIGN KEY (`Doctor_ID`) REFERENCES `User` (`User_ID`);
ALTER TABLE `Treatment` ADD CONSTRAINT `fk_处置_Medical_Record_1` FOREIGN KEY (`Medical_Record_ID`) REFERENCES `Medical_Record` (`Medical_Record_ID`);
ALTER TABLE `Commonly_Used_Diagnosis` ADD CONSTRAINT `fk_常用诊断_User_1` FOREIGN KEY (`Doctor_ID`) REFERENCES `User` (`User_ID`);
ALTER TABLE `Commonly_Used_Diagnosis` ADD CONSTRAINT `fk_常用诊断_Disease_1` FOREIGN KEY (`Disease_ID`) REFERENCES `Disease` (`Disease_ID`);
ALTER TABLE `Group_Prescription_Items` ADD CONSTRAINT `fk_Prescription_Group_Items_处方组套_1` FOREIGN KEY (`Group_Prescription_ID`) REFERENCES `Group_Prescription` (`Group_Prescription_ID`);
ALTER TABLE `Group_Prescription_Items` ADD CONSTRAINT `fk_Prescription_Group_Items_药品收费项目表_1` FOREIGN KEY (`Drags_ID`) REFERENCES `Drugs` (`Drugs_ID`);
ALTER TABLE `Examination_Result` ADD CONSTRAINT `fk_Examination_Result_检查检验明细_1` FOREIGN KEY (`Examination_Result_ID`) REFERENCES `Examination_Fmedical_Items` (`Examination_Result_ID`);
ALTER TABLE `Examination_Drugs_Items` ADD CONSTRAINT `fk_检查检验药品明细_药品收费项目表_1` FOREIGN KEY (`Drugs_ID`) REFERENCES `Drugs` (`Drugs_ID`);
ALTER TABLE `检查检验组套药品明细` ADD CONSTRAINT `fk_检查检验组套药品明细_Fmedical_Items_1` FOREIGN KEY (`检查检验模板ID`) REFERENCES `Fmedical_Items` (`Fmedical_Items_ID`);
ALTER TABLE `检查检验组套药品明细` ADD CONSTRAINT `fk_检查检验组套药品明细_药品收费项目表_1` FOREIGN KEY (`药品id`) REFERENCES `Drugs` (`Drugs_ID`);
ALTER TABLE `Group_Examination_Drugs_Items` ADD CONSTRAINT `fk_Group_Examination_Drugs_Items_药品收费项目表_1` FOREIGN KEY (`Drugs_ID`) REFERENCES `Drugs` (`Drugs_ID`);
ALTER TABLE `Group_Examination_Fmedical_Items` ADD CONSTRAINT `fk_Group_Examination_Fmedical_Items_检查检验组套_1` FOREIGN KEY (`Group_Examination_ID`) REFERENCES `Group_Examination` (`Group_Examination_ID`);
ALTER TABLE `Group_Examination_Fmedical_Items` ADD CONSTRAINT `fk_Group_Examination_Fmedical_Items_Fmedical_Items_1` FOREIGN KEY (`Fmedical_Items_ID`) REFERENCES `Fmedical_Items` (`Fmedical_Items_ID`);
ALTER TABLE `Diagnosis_Template` ADD CONSTRAINT `fk_Diagnosis_Template_Medical_Record_Home_Page_Template_1` FOREIGN KEY (`Medical_Record_Home_Page_Template_ID`) REFERENCES `Medical_Record_Home_Page_Template` (`Medical_Record_Home_Page_Template_ID`);
ALTER TABLE `Diagnosis_Template` ADD CONSTRAINT `fk_Diagnosis_Template_Disease_1` FOREIGN KEY (`Disease_ID`) REFERENCES `Disease` (`Disease_ID`);
ALTER TABLE `Medical_Record_Home_Page_Template` ADD CONSTRAINT `fk_Medical_Record_Home_Page_Template_User_1` FOREIGN KEY (`Doctor_ID`) REFERENCES `User` (`User_ID`);
ALTER TABLE `Constant_Type` ADD CONSTRAINT `fk_Constant_Type_Constant_Items_1` FOREIGN KEY (`Constant_Type_ID`) REFERENCES `Constant_Items` (`Constant_Type_ID`);
ALTER TABLE `Constant_Items` ADD CONSTRAINT `fk_Constant_Items_Department_1` FOREIGN KEY (`Constant_Items_ID`) REFERENCES `Department` (`Department_CategoryID`);
ALTER TABLE `Scheduling_Info` ADD CONSTRAINT `fk_Scheduling_Info_User_1` FOREIGN KEY (`Doctor_ID`) REFERENCES `User` (`User_ID`);
ALTER TABLE `Scheduling_Rule` ADD CONSTRAINT `fk_Scheduling_Rule_User_1` FOREIGN KEY (`Doctor_ID`) REFERENCES `User` (`User_ID`);
ALTER TABLE `Examination_Drugs_Items` ADD CONSTRAINT `fk_Examination_Drugs_Items_Examination_Fmedical_Items_1` FOREIGN KEY (`Examination_Fmedical_Items_ID`) REFERENCES `Examination_Fmedical_Items` (`Examination_Items_ID`);
ALTER TABLE `Examination_Drugs_Items` ADD CONSTRAINT `fk_Examination_Drugs_Items_User_1` FOREIGN KEY (`Doctor_ID`) REFERENCES `User` (`User_ID`);
ALTER TABLE `Group_Examination_Drugs_Items` ADD CONSTRAINT `fk_Group_Examination_Drugs_Items_Group_Examination_Fmedical_Items_1` FOREIGN KEY (`Group_Examination_Fmedical_Items_ID`) REFERENCES `Group_Examination_Fmedical_Items` (`Group_Examination_Fmedical_Items_ID`);

