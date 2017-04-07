# Equality
参考:[Equality](http://nshipster.cn/equality/)

## 相等性 & 本体性

当两个物体有一系列相同的可观测的属性时，两个物体可能是互相`相等`或者`等价`的。但这两个物体本身仍然是`不同的` ，它们各自有自己的`本体`。 在编程中，一个对象的本体和它的内存地址是相关联的。

NSObject使用 `isEqual:`这个方法来测试和其他对象的相等性。在它的基类实现中，相等性检查本质上就是对本体性的检查。两个 NSObject 如果指向了同一个内存地址，那它们就被认为是相同的。

```
@implementation NSObject (Approximate)
- (BOOL)isEqual:(id)object {
return self == object;
}
@end

```

对于 NSArray，NSDictionary 和 NSString 这种容器类来说，大家所期望的，同时也是更加有用的行为，应该是进行深层的相等性检查，对于集合中的每个成员都进行判断。

NSObject 的子类在实现它们自己的 isEqual: 方法时，应该完成下面的工作：

- 实现一个新的`isEqualTo__ClassName__`方法，进行实际意义上的值的比较。
- 重载 isEqual: 方法进行类和对象的本体性检查，如果失败则回退到上面提到的值比较方法。
- 重载 hash 方法。

在 Foundation 框架中，下面这些 NSObject 的子类都有自己的相等性检查实现，分别使用下面这些方法:

- NSAttributedString -isEqualToAttributedString:
- NSData -isEqualToData:
- NSDate -isEqualToDate:
- NSDictionary -isEqualToDictionary:
- NSHashTable -isEqualToHashTable:
- NSIndexSet -isEqualToIndexSet:
- NSNumber -isEqualToNumber:
- NSOrderedSet -isEqualToOrderedSet:
- NSSet -isEqualToSet:
- NSString -isEqualToString:
- NSTimeZone -isEqualToTimeZone:
- NSValue -isEqualToValue:

对上面这些类来说，当需要对它们的两个实例进行比较时，推荐使用这些高层方法而不是直接使用`isEqual:`。


## hash

对于面向对象编程来说，对象相等性检查的主要用例，就是确定一个对象是不是一个集合的成员。为了加快这个过程，子类当中需要实现`hash`方法：

- 对象相等具有`交换性`（[a isEqual:b] ⇒ [b isEqual:a])
- 如果两个对象相等，它们的 hash 值也一定是相等的 ([a isEqual:b] ⇒ [a hash] == [b hash])
- 反过来则不然，两个对象的散列值相等不一定意味着它们就是相等的 ([a hash] == [b hash] ¬⇒ [a isEqual:b])


[散列表](https://zh.wikipedia.org/wiki/%E5%93%88%E5%B8%8C%E8%A1%A8)是程序设计中基础的数据结构之一，它使得`NSSet`和`NSDictionary`能够非常快速地(O(1)) 进行元素查找。

通过把散列表和数组进行对比，有助于我们更好地理解散列表的性质：

**数组**把元素存储在一系列连续的地址当中，例如一个容量为 n 的数组当中，包含了位置 0，1 一直到 n-1 这么多空白的槽位。要判断一个元素是不是在数组中存在，需要对数组中每个元素的位置都进行检查（除非数组当中的元素是已经排序过的，那是另一回事了）。

**散列表**使用了一个不太一样的办法。相对于数组把元素按顺序存储(0, 1, ..., n-1)，散列表在内存中分配 n 个位置，然后使用一个函数来计算出位置范围之内的某个具体位置。散列函数需要具有确定性。一个 好的 散列函数在不需要太多计算量的情况下，可以使得生成的位置分布接近于均匀分布。当两个不同的对象计算出相同的散列值时，我们称其为发生了 散列碰撞 。当出现碰撞时，散列表会从碰撞产生的位置开始向后寻找，把新的元素放在第一个可供放置的位置。随着散列表变得越来越致密，发生碰撞的可能性也会随之增加，导致查找可用位置花费的时间也会增加（这也是为什么我们希望散列函数的结果分布更接近于均匀分布）。

总结一下:

- 什么时候会调用isEqual方法。
	+ 对象调用 isEqual
	+ 集合类型在判断相等性时，containsObject[Array, Set]
	+ NSMutableSet的 addObject 方法。
- 什么时候会调用hash方法。
	+ hash和isEqual。
		`Set`和`Dictionary`在判断成员是否相等时，会调用hash。<br>
		`Set`成员的`hash`值是否和目标`hash`值相等, 如果不等, 直接判断不相等如果相同则进行对象判等(isEqual:), 作为判等的结果。
	+ `hash`方法只在对象被添加至`NSSet`和设置为`NSDictionary`的`key`时会调用
		`NSSet`添加新成员时, 需要根据hash值来快速查找成员, 以保证集合中是否已经存在该成员
		`NSDictionary`在查找`key`时, 也利用了`key`的`hash`值来提高查找的效率

# 深拷贝 & 浅拷贝 与 copy & strong

## 深拷贝 & 浅拷贝
[参考](https://www.zybuluo.com/MicroCai/note/50592)

## copy、strong in property

strong对应的`setter`方法，是将_property先release（_property release），然后将参数`retain`（property retain），最后是_property = property。
copy对应的`setter`方法，是将_property先release（_property release），然后拷贝参数内容（property copy），创建一块新的内存地址，最后_property = property。
