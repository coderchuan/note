## js对象序列化为querystring
* `jQuery.param(object[,traditional])`
    * `object`:object/json,要序列化的对象
    * `traditional`:bool。默认为false
        * 当此值为true时，进行浅度序列化。即值为数组或对象时只转化为字面的'Array'或'Object'。
        * 当此值为false时，进行深度序列化。
