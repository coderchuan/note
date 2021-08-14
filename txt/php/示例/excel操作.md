## Excel操作
```php
/* 
 * 使用环境：Yii2
 * 包管理方式：composer
 * 依赖：phpspreadsheet
 * 安装依赖：composer require phpoffice/phpspreadsheet
 * 添加到项目：将此类放入"YII项目目录/models"
 */

namespace app\models;

use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\IOFactory;
use PhpOffice\PhpSpreadsheet\Cell\Coordinate;
use PhpOffice\PhpSpreadsheet\Chart\Chart;
use PhpOffice\PhpSpreadsheet\Chart\DataSeries;
use PhpOffice\PhpSpreadsheet\Chart\DataSeriesValues;
use PhpOffice\PhpSpreadsheet\Chart\PlotArea;
use PhpOffice\PhpSpreadsheet\Chart\Title;
use PhpOffice\PhpSpreadsheet\Style\NumberFormat;
use PhpOffice\PhpSpreadsheet\Style\Fill;
use PhpOffice\PhpSpreadsheet\Style\Border;
use PhpOffice\PhpSpreadsheet\Style\Alignment;

class ExcelOption extends \yii\base\BaseObject
{   

    //function          读取excel
    //file_path         文件路径
    //index             文件路径，sheet_id，从0开始
    //return            data["code"=>错误码0:正常,其他值:自定义,'sheet_name'=>index:name,"msg"=>消息,'current_index'=>当前返回的sheet数据的sheet_id,'sheet_data'=>sheet数据,数组]
    public static function getExcelData(string $file_path,string $type="xlsx",int $index=0){
        $data=[
            "code"=>0,
            "msg"=>"未处理",
            "sheet_name"=>[],
            "current_index"=>0,
            "sheet_data"=>[],
        ];
        if(!is_file($file_path)){
            $data["msg"]="文件不存在";
            $data["code"]=1;
            return $data;
        }
        $file_type="xlsx";
        if(strtolower($type)=="xlsx"){
            $file_type="Xlsx";
        }else if(strtolower($type)=="xls"){
            $file_type="Xls";
        }else{
            $data["msg"]="文件类型错误";
            $data["code"]=2;
            return $data;
        }
        $reader=IOFactory::createReader($file_type);
        $names=$reader->listWorksheetNames($file_path);
        if(empty($names))$names=[];
        if(!isset($names[$index])){
            $data['code']="3";
            $data["msg"]="指定的sheet_id不存在";
            return $data;
        }
        $spreadsheet=$reader->load($file_path);
        $sheet=$spreadsheet->getSheet($index);

        $sheet_data=[];
        $col_max_letter=$sheet->getHighestColumn();
        $col_max_num=self::stringToIndex($col_max_letter);
        $row_max_num=$sheet->getHighestRow();

        for($x=1;$x<=$row_max_num;++$x)
        {   
            $temp_row=[];
            for($y=1;$y<=$col_max_num;++$y){
                $col_letter=self::indexToString($y);
                $temp_row[]=$sheet->getCell($col_letter.$x)->getValue();
            }
            $sheet_data[]=$temp_row;
        }

        $data['code']=0;
        $data['msg']="读取成功";
        $data['current_index']=$index;
        $data['sheet_name']=$names;
        $data['sheet_data']=$sheet_data;
        return $data;
    }

    //function          创建一个EXCEL实例。此实例中包含一个默认的sheet 
    //spreadsheet       引用参数。函数执行完成后会将此变量的值赋值为创建好的EXCEL实例
    //firstSheetName    默认sheet的名称,如果不填写此参数或者此参数的值empty($firstSheetName)为真，则使用默认的sheet名称"Worksheet"。
    //sheet             引用参数。函数执行完成后会将此变量的值赋值为创建好的sheet实例 
    public static function createExcelObj(&$spreadsheet,string $firstSheetName='',&$sheet=null) 
    {
        $spreadsheet=new Spreadsheet();
        $sheet=$spreadsheet->getSheet(0);
        $sheet->getProtection()->setSheet(true);
        $firstSheetName=self::stringFilter($firstSheetName);
        if(!empty($firstSheetName))$sheet->setTitle($firstSheetName);
    }
    //function          数字列坐标转字母列坐标
    //index             数字。从1起始
    public static function indexToString(int $index)
    {
        return Coordinate::stringFromColumnIndex($index);
    }
    //function          字母列坐标转数字列坐标 
    //index             字母 
    public static function stringToIndex(string $letter)
    {
        return Coordinate::columnIndexFromString($letter);
    }
    //function          添加超链接 
    //sheet             引用参数。传入要进行设置的sheet实例 
    //cell              单个表格坐标，形式为 A1 表示A列的第1行  
    //link              超链接
    //value             值。 
    public static function setHref(&$sheet,string $cell,$link,$value=null)
    {
        if($value!==null)self::setValue($sheet,$cell,$value);
        $sheet->getCell($cell)->getHyperlink()->setUrl($link);
    }
    //function          保存文件
    //spreadsheet       引用参数。传入EXCEL的实例
    //dirPath           保存文件的路径
    //fileName          保存文件的名称 
    public static function saveFile(&$spreadsheet,$dirPath,$fileName='new_execel') 
    {
        $writer = IOFactory::createWriter($spreadsheet, 'Xlsx');
        $writer->setIncludeCharts(true);
        $dirPath=self::stringFilter($dirPath,'dir');
        $dirPath=preg_replace("/\\+\$|\/+\$/u",'',$dirPath);
        $fileName=self::stringFilter($fileName);
        $fileName=preg_replace("/\\.[\s\S]+?\$/u",'',$fileName);
        $writer->save($dirPath.DIRECTORY_SEPARATOR.$fileName.".xlsx");
    }

    //function          创建sheet   
    //spreadsheet       引用参数。传入EXCEL的实例
    //sheet             引用参数。函数执行完成后会将此变量的值赋值为创建好的sheet实例
    //sheetName         将要创建的sheet的名称 
    public static function createSheet(&$spreadsheet,&$sheet,string $sheetName='')
    {
        $sheetName=self:: stringFilter($sheetName);
        if($sheetName=='')
        {
            $sheet=$spreadsheet->createSheet();                                         
        }
        else $sheet=$spreadsheet->createSheet()->setTitle($sheetName);                  
        $sheet->getProtection()->setSheet(true);        
    }
    
    //function          通过sheet名获取sheet实例                                        
    //spreadsheet       引用参数。传入EXCEL的实例                                       
    //sheetName         sheet名                                                                  
    //sheet             引用参数。函数执行完成后会将此变量的值赋值为获取的实例
    public static function getSheetByName(&$spreadsheet,$sheetName='',&$sheet)          
    {                                                      
        $sheet=$spreadsheet->getSheetByName($sheetName);                                
    }     

    //function          通过id获取sheet实例                                       
    //spreadsheet       引用参数。传入EXCEL的实例       
    //id                sheet id                          
    //sheet             引用参数。函数执行完成后会将此变量的值赋值为获取的实例                                                                       
    public static function getSheetById(&$spreadsheet,int $id=0,&$sheet)                
    {                                                   
        $sheet=$spreadsheet->getSheet($id);                                             
    }    
    //function          删除sheet                             
    //spreadsheet       引用参数。传入EXCEL的实例   
    //sheet             引用参数。函数执行完成后会将此变量的值赋值为获取的实例                                                        
    public static function delSheet(&$spreadsheet,&$sheet)                
    {                                       
        $sheetIndex = $spreadsheet->getIndex($sheet);
        $spreadsheet->removeSheetByIndex($sheetIndex);                                   
    }    
    //function          获取当前活动的sheet实例                              
    //spreadsheet       引用参数。传入EXCEL的实例                   
    //sheet             引用参数。函数执行完成后会将此变量的值赋值为获取的实例                                      
    public static function getActiveSheet(&$spreadsheet,&$sheet)                        
    {         
        $sheet=$spreadsheet->getActiveSheet();                                          
    }     

    //function          设置sheet名
    //return            当empty($sheetName)为真时返回false 
    //sheet             引用参数。传入要设置sheet名的sheet实例      
    //sheetName         要设置的sheet名称                           
    public static function setSheetName(&$sheet,string $sheetName='')                   
    {                                                     
        $sheetName=self::stringFilter($sheetName);
        if(empty($sheetName))return false;                                                 
        $sheet->setTitle($sheetName);                                                   
    }  
    
    //function          设置表格值
    //sheet             引用参数。传入要设置值的sheet实例 
    //cell              单个表格坐标，形式为 A1 表示A列的第1行  
    //value             值。要设置的值 
    //dataType          数据类型  参考 \PhpOffice\PhpSpreadsheet\Cell\DataType
    //                      "str"       字符串
    //                      "n"         数字 
    //                      "%.2"       2位小数百分比
    //                      "%"         整数百分比                                    
    public static function setValue(&$sheet,string $cell="",$value="",string $dataType="str") 
    {                        
        $sheet->getStyle($cell)->getAlignment()->setWrapText(true);
        switch($dataType)     
        {
            case "str":
                $sheet->getStyle($cell)->getNumberFormat()->setFormatCode(NumberFormat::FORMAT_TEXT);
                break;
            case "%":
                $sheet->getStyle($cell)->getNumberFormat()->setFormatCode(NumberFormat::FORMAT_PERCENTAGE);
                break;
            case "%.2":
                $sheet->getStyle($cell)->getNumberFormat()->setFormatCode(NumberFormat::FORMAT_PERCENTAGE_00);
                break;
            case "%.2":
                $sheet->getStyle($cell)->getNumberFormat()->setFormatCode(NumberFormat::FORMAT_PERCENTAGE_00);
                break;
            case "n":
                $sheet->getStyle($cell)->getNumberFormat()->setFormatCode(NumberFormat::FORMAT_GENERAL);
                break;
        }       
        $sheet->setCellValue($cell,$value);
    }  

    //function          设置背景颜色
    //sheet             引用参数。传入要设置背景颜色的sheet实例 
    //cells             表格坐标，A1 表示A列的第1行;A1:B2 表示从A列的第1行到B列的第2行的区域设置背景颜色
    //color             颜色 从左往右数 其中第1,2位表示R的十六进制值;第3,4位表示G的十六进制值;第5,6位表示B的十六进制值;
    public static function setBackgroundColor(&$sheet,string $cells="",$color='FFFFFF') 
    {
        $sheet->getStyle($cells)->getFill()->setFillType(Fill::FILL_SOLID);
        $sheet->getStyle($cells)->getFill()->getStartColor()->setRGB($color);
    }   
    //function          设置字体颜色
    //sheet             引用参数。传入要设置字体颜色的sheet实例 
    //cells             表格坐标，A1 表示A列的第1行;A1:B2 表示从A列的第1行到B列的第2行的区域设置背景颜色
    //color             颜色 从左往右数 其中第1,2位表示R的十六进制值;第3,4位表示G的十六进制值;第5,6位表示B的十六进制值;
    public static function setColor(&$sheet,string $cells="",$color='FFFFFF') 
    {
        $sheet->getStyle($cells)->getFont()->getColor()->setRGB($color);
    }

    //function          设置默认行高
    //sheet             引用参数。传入要背景颜色的sheet实例 
    //height            默认行高 
    public static function setDefaultRowHeight($sheet,$height)
    {   
        $sheet->getDefaultRowDimension()->setRowHeight($height);
    }  
    
    //function          隐藏或显示风格线
    //sheet             引用参数。传入要背景颜色的sheet实例 
    //show              true表示显示，false表示隐藏
    public static function showGridlines($sheet,bool $show)
    {
        $sheet->setShowGridlines($show);
    }  

    //function          设置边框
    //sheet             引用参数。传入要进行设置的sheet实例 
    //cells             表格坐标。A1 表示A列的第1行;A1:B2 表示从A列的第1行到B列的第2行的区域
    //border            边框方位。  1 表示选定区域的上方
    //                              2 表示选定区域的下方
    //                              3 表示选定区域的左方
    //                              4 表示选定区域的右方
    //                              5 表示选定区域的内部及周围                            
    //color             颜色 从左往右数 6位 其中第1,2位表示R的十六进制值;第3,4位表示G的十六进制值;第5,6位表示B的十六进制值;
    public static function setBorderStyle(&$sheet,string $cells="",string $color="000000",int $border=5)
    {
        switch($border)
        {
            case 1:
                $sheet->getStyle($cells)->getBorders()->getTop()->setBorderStyle(Border::BORDER_THIN);              //上边框
                $sheet->getStyle($cells)->getBorders()->getTop()->getColor()->setRGB($color);                                               //设置边框颜色 参数中的前两个字符表示透明度的十六进制值
                break;
            case 3:
                $sheet->getStyle($cells)->getBorders()->getBottom()->setBorderStyle(Border::BORDER_THIN);           //下边框
                $sheet->getStyle($cells)->getBorders()->getBottom()->getColor()->setRGB($color);
                break;
            case 4:
                $sheet->getStyle($cells)->getBorders()->getLeft()->setBorderStyle(Border::BORDER_THIN);             //左边框
                $sheet->getStyle($cells)->getBorders()->getLeft()->getColor()->setRGB($color);
                break;
            case 2:
                $sheet->getStyle($cells)->getBorders()->getRight()->setBorderStyle(Border::BORDER_THIN);            //右边框
                $sheet->getStyle($cells)->getBorders()->getRight()->getColor()->setRGB($color);
                break;
            case 5:
            default:
                $sheet->getStyle($cells)->getBorders()->getAllBorders()->setBorderStyle(Border::BORDER_THIN);       //全部边框 
                $sheet->getStyle($cells)->getBorders()->getAllBorders()->getColor()->setARGB($color);
                break;
        }      
    }

    //function          合并单元格 
    //sheet             引用参数。传入要进行设置的sheet实例 
    //cells             表格坐标。A1 表示A列的第1行;A1:B2 表示从A列的第1行到B列的第2行的区域
    public static function mergeCells(&$sheet,string $cells="")
    {
        $sheet->mergeCells($cells);
    }

    //function          拆分单元格 
    //sheet             引用参数。传入要进行设置的sheet实例 
    //cells             表格坐标。A1 表示A列的第1行;A1:B2 表示从A列的第1行到B列的第2行的区域 
    public static function unMergeCells(&$sheet,string $cells="")
    {
        $sheet->unmergeCells($cells);
    }
    
    //function          设置行高 
    //sheet             引用参数。传入要进行设置的sheet实例 
    //rowNo             行序号
    //height            高度。单位为磅(1cm=28.6磅)
    public static function setHeight(&$sheet,int $rowNo,$height=30)
    {
        $sheet->getRowDimension($rowNo)->setRowHeight($height);
    }
    
    //function          设置宽度 
    //sheet             引用参数。传入要进行设置的sheet实例 
    //colNo             列序号
    //width             宽度。单位为1/10英寸(1/10英寸为2.54mm) 
    public static function setWidth(&$sheet,string $colNo,$width=25)
    {
        $sheet->getColumnDimension($colNo)->setWidth($width);
    }

    //function              设置对齐 
    //sheet                 引用参数。  传入要进行设置的sheet实例 
    //cells                 表格坐标。  A1 表示A列的第1行;A1:B2 表示从A列的第1行到B列的第2行的区域 
    //verticalDirection     垂直对齐方式。  
    //                          1   上对齐
    //                          2   中对齐
    //                          3   下对齐
    //                          4   垂直两端对齐
    //                          5   垂直分散对齐 
    //horizontalDirection   水平对齐方式。  
    //                          1   左对齐
    //                          2   中对齐
    //                          3   右对齐
    //                          4   常规对齐
    //                          5   跨列居中
    //                          6   水平两端对齐
    //                          7   水平分散对齐
    //                          8   复制填充
    public static function setAlignStyle(&$sheet,string $cells,int $verticalDirection=4, int $horizontalDirection=1)  
    {   
        switch($horizontalDirection)
        {
            case 1:
                $sheet->getStyle($cells)->getAlignment()->setHorizontal(Alignment::HORIZONTAL_LEFT);                //左对齐
                break;
            case 2:
                $sheet->getStyle($cells)->getAlignment()->setHorizontal(Alignment::HORIZONTAL_CENTER);              //中对齐
                break;
            case 3:
                $sheet->getStyle($cells)->getAlignment()->setHorizontal(Alignment::HORIZONTAL_RIGHT);               //右对齐
                break;
            case 5:
                $sheet->getStyle($cells)->getAlignment()->setHorizontal(Alignment::HORIZONTAL_CENTER_CONTINUOUS);   //跨列居中
                break;
            case 6:
                $sheet->getStyle($cells)->getAlignment()->setHorizontal(Alignment::HORIZONTAL_JUSTIFY);             //水平两端对齐
                break;
            case 7:
                $sheet->getStyle($cells)->getAlignment()->setHorizontal(Alignment::HORIZONTAL_DISTRIBUTED);         //水平分散对齐
                break;
            case 8:
                $sheet->getStyle($cells)->getAlignment()->setHorizontal(Alignment::HORIZONTAL_FILL);                //复制填充
                break;
            case 4:
            default :
                $sheet->getStyle($cells)->getAlignment()->setHorizontal(Alignment::HORIZONTAL_GENERAL);             //常规对齐
                break;
        }
        
        switch($verticalDirection)
        {
            case 2:
                $sheet->getStyle($cells)->getAlignment()->setVertical(Alignment::VERTICAL_CENTER);      //中对齐 
                break;
            case 3:
                $sheet->getStyle($cells)->getAlignment()->setVertical(Alignment::VERTICAL_BOTTOM);      //下对齐 
                break;
            case 4:
                $sheet->getStyle($cells)->getAlignment()->setVertical(Alignment::VERTICAL_JUSTIFY);     //垂直两端对齐 
                break;
            case 5:
                $sheet->getStyle($cells)->getAlignment()->setVertical(Alignment::VERTICAL_DISTRIBUTED); //垂直分散对齐  
                break;
            case 1:
            default:
                $sheet->getStyle($cells)->getAlignment()->setVertical(Alignment::VERTICAL_TOP);         //上对齐 
                break;
        }
    } 

    //function              生成单列无图例柱状图
    //sheet                 引用参数。传入要进行设置的sheet实例 
    //xAxisLabelCells       X轴的标签。使用表格坐标范围
    //xAxisValueCells       X轴每个标签对应的值。使用表格坐标范围 
    //title                 柱状图标题。如果值的格式满足单个表格坐标的形式，则使用该单元格的值作为标题，否则使用此值作为标题 
    //chartArea             显示柱状图的区域。使用表格坐标范围
    public static function createHistogram(&$sheet,string $xAxisLabelCells,string $xAxisValueCells,string $title,string $chartArea) 
    {   
        if(preg_match("/^[^:\\d]+(\\d+):[^:\\d]+(\\d+)\$/u",$xAxisLabelCells,$match))
        {
            if($match[2]<$match[1])return ;
        }
        if(preg_match("/^[^:\\d]+(\\d+):[^:\\d]+(\\d+)\$/u",$xAxisValueCells,$match))
        {
            if($match[2]<$match[1])return ;
        }


        $sheetName=$sheet->getTitle();
        //X轴标签
        $xLabels = [
            new DataSeriesValues(DataSeriesValues::DATASERIES_TYPE_STRING, $sheetName.'!'.$xAxisLabelCells, null, 12), // Jan to Dec
        ];

        //X轴标签所对应的值
        $xValues = [
            new DataSeriesValues(DataSeriesValues::DATASERIES_TYPE_NUMBER, $sheetName.'!'.$xAxisValueCells, null, 12),
        ];

        //图表标题 
        if(preg_match("/^[A-Z]+\d+$/u",$title))
        {
            $title=$sheet->getCell($title)->getValue();
        }
        $titleObj=new Title($title);

        //图表数据
        $data = new DataSeries(                             
            DataSeries::TYPE_BARCHART,                      
            DataSeries::GROUPING_CLUSTERED,                 
            range(0,count($xValues)-1),                     
            [],                                   
            $xLabels,                                       
            $xValues                                        
        );
        
        //图表方向
        $data->setPlotDirection(DataSeries::DIRECTION_COL);

        //图表结构 
        $plotArea=new PlotArea(null,[$data]);
        $chart=new Chart(
            $sheetName.'_'.$title, 
            $titleObj,
            null,  
            $plotArea,  
            true,  
            'gap',  
            null,  
            null   
        );

        //添加图表到sheet中
        if(preg_match("/^([^:]+):([^:]+)\$/u",$chartArea,$match))
        {
            $startCoor=$match[1];
            $endCoor=$match[2];
            $chart->setTopLeftPosition($startCoor);
            $chart->setBottomRightPosition($endCoor);
            $sheet->addChart($chart);
        }
    }
    //function              设置字体,字号,是否加粗
    //sheet                 引用参数。传入要进行设置的sheet实例 
    //cells                 表格坐标。  A1 表示A列的第1行;A1:B2 表示从A列的第1行到B列的第2行的区域 
    //font                  字体名称。例如:宋体 
    //fontSize              字体大小。例如：14 
    //isBold                是否加粗。true表示加粗;false表示不加粗
    public static function setFont(&$sheet,string $cells,string $font,int $fontSize=null,bool $isBold=false)
    {
        if(!empty($font))$sheet->getStyle($cells)->getFont()->setName($font);
        if(!empty($fontSize))$sheet->getStyle($cells)->getFont()->setSize($fontSize);
        $sheet->getStyle($cells)->getFont()->setBold($isBold);
    }
    /*
     * function     合并多个表格的第一个sheet
     * files        要合并的文件。建议填写文件的绝对路径
     * save_path    合并后的文件的保存路径
     * file_name    合并后的文件名称
     */
    public static function mergeExcel(array $files=[],string $save_path='',string $file_name='')
    {
        if(!is_dir($save_path)){
            return self::returnMessage(1,"保存的文件路径不存在");
        }if(!preg_match("{\\\\\$|/}u",$save_path)){
            $save_path=$save_path.DIRECTORY_SEPARATOR;
        }

        $file_type="Xlsx";
        $reader=IOFactory::createReader($file_type);
        $reader->setIncludeCharts(true);
        
        self::createExcelObj($excel_obj);
        $temp=$excel_obj->getSheet(0);
        self::delSheet($excel_obj,$temp);
        $suc_num=0;
        $fai_num=0;
        foreach($files as $file){
            if(is_file($file)){
                $sheet=$reader->load($file)->getSheet(0);
                $excel_obj->addExternalSheet($sheet)->setShowGridlines(false);
                ++$suc_num;
            }else{
                self::myLog("文件 {$file} 不存在");
                ++$fai_num;
            }
        }
        if($suc_num){
            self::myLog("将合并 {$suc_num} 个表格");
        }
        if($fai_num){
            self::myLog("{$fai_num} 个表格未合并");
        }
        if(empty($suc_num)){
            return self::returnMessage(1,"没有需要合并的表格");
        }

        self::saveFile($excel_obj,$save_path,$file_name);
        return self::returnMessage(0,"{$save_path}{$file_name}.xlsx 已保存");
    }
    
    //function              字符过滤
    //str                   要过滤的字符串
    //type                  过滤类型
    //                          file    文件名
    //                          dir     文件夹名
    //                          sheet   sheet名
    public static function  stringFilter($str,$type='sheet'){
        switch($type){
            default:
            case "file":
            case "sheet":
                $pattern="{[\\[\\]\\. \/\\-\\+\\\\\\(\\)]+}u";
                break;
            case "dir":
                $pattern="{[ \\-\\+]+}u";
                break;
        }
        $str=preg_replace($pattern,"_",$str);
        return preg_replace("{^_+|_+\$}u","",$str);
    }
    /*  
     *  function 屏幕打印，兼容Windows与Linux
     */ 
    public static function myLog($content) 
    {
        print_r(date("[Y/m/d H:i:s] ").$content."\n");
    }
    /* 
     *  function    格式化返回消息
     *  code        int     返回码。0表示正常执行，其他值自定义
     *  msg         string  返回消息
     *  return      array   返回值
     *                          code    
     *                          msg     
     */ 
    public static function returnMessage(int $code=0,string $msg="success")
    {
        return ["code"=>$code,"msg"=>$msg];
    }
}
```

