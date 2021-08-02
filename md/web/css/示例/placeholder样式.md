## placeholder样式
```css
.placeholder_style{
    --color:#0284C3;    
}.placeholder_style::-webkit-input-placeholder{
    color: var(--color); 
}.placeholder_style::-moz-placeholder{
    color: var(--color);
}.placeholder_style:-ms-input-placeholder{  /* ie不支持css变量 */ 
    color: #0284C3;
}
```