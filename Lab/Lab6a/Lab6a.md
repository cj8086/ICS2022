# 

```python
def intToBin(number, index, feature=True):
	# """index为该数据位宽,number为待转换数据,
	# feature为True则进行十进制转二进制，为False则进行二进制转十进制。"""
	if feature:  # 十进制转换为二进制
		if number >= 0:
			b = bin(number)
			b = '0' * (index + 2 - len(b)) + b
		else:
			b = 2 ** index + number
			b = bin(b)
			b = '1' * (index + 2 - len(b)) + b  # 注意这里算出来的结果是补码
			b = b.replace("0b", '')
			b = b.replace('-', '')
			
			return b
		elif not feature:  # 二进制转换为十进制
			i = int(str(number), 2)
			if i >= 2 ** (index - 1):  # 如果是负数
				i = -(2 ** index - i)
				return i
			else:
				return i
			
			
			for x in range(-16, 0):
    print("The complement of " + str(x) + " is " + intToBin(x, 5, True))
```
