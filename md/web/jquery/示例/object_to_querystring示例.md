## js对象序列化为querystring
```js
var params={
    age:26,
    name:'yang',
    language:'简体中文',
    other:[1,2,3]
};
var querystring=$.param(params);
console.log(querystring);
//"age=26&name=yang&language=%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87&other%5B%5D=1&other%5B%5D=2&other%5B%5D=3"
var querystring=$.param(params,true);
console.log(querystring);
//"age=26&name=yang&language=%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87&other=1&other=2&other=3"
```
