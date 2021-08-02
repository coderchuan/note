## 获取机器唯一码与MAC地址
```php
/**
 * 获取mac地址和唯一机器码。仅适用于linux或windows
 * @return array 数组内容如下 
 * - code int 返回代码
 * -- 0 获取成功
 * -- 1 不支持的运行环境
 * - mac array 由mac地址组成的数组 
 * - uuid string 唯一机器码
 */
function getMachineUuid()
{
    $retMsg=array(
        "code"=>1,
        "mac"=>array(),
        "uuid"=>"",
    );
    if(preg_match("{win}ui",PHP_OS)){
        $command="getmac";
    }else if(preg_match("{lin}ui",PHP_OS)){
        $command="find /sys/ -type f -name address | grep devices | grep -v virtual 2>/dev/null | xargs cat | grep -Pio \"^[0-9A-F:]{17}\$\"";
    }else return $retMsg;

    exec($command,$a);
    $mac=array();
    foreach($a as $v){
        if(preg_match("/([0-9A-F\\-:]{17})/ui",$v,$res)){
            $mac[]=strtolower($res[1]);
        }
    }
    $mac=array_values(array_unique($mac));
    $mac=preg_replace("{-}",":",$mac);

    $retMsg['code']=0;
    $retMsg['mac']=$mac;
    $retMsg['uuid']=md5(implode("",$mac));
    return $retMsg;
}
```
