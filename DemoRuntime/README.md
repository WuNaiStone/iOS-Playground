# iOS-RuntimeDemo

Demo for iOS runtime.

## 获取成员变量

```
// 获取所有成员变量，对于属性会自动生成_成员变量
Ivar *ivars = class_copyIvarList([UIView class], &count);
```

```
const char *ivarName = ivar_getName(ivar); // runtime是用C写的。
const char *ivarType = ivar_getTypeEncoding(ivar);
```

## 获取属性

```
// 获取所有属性
objc_property_t *properties = class_copyPropertyList([UIView class], &count);
```

```
const char *propertyName = property_getName(property);
const char *propertyAttr = property_getAttributes(property);
```

## 获取方法
```
// 获取所有方法
Method *methods = class_copyMethodList([UIView class], &count);
```

```
// 方法类型是SEL选择器类型
SEL methodName = method_getName(method);
```

## 设置UIButton背景色
```
btn1.backgroundColor = [UIColor greenColor];
[btn1 setBackgroundColor:[UIColor greenColor] forState:UIControlStateNormal];
[btn1 setBackgroundColor:[UIColor blueColor] forState:UIControlStateHighlighted];
```

## 解决UIButton重复点击问题
```
btn.cs_acceptEventInterval = 1;
```

## 使用runtime将JSON转成Model
```
- (void)prepareModel:(NSDictionary *)dict {
    NSMutableArray *keys = [[NSMutableArray alloc] init];

    u_int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char *propertyCString = property_getName(property);
        NSString *propertyName = [NSString stringWithCString:propertyCString encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
    }
    free(properties);

    for (NSString *key in keys) {
        if ([dict valueForKey:key]) {
            [self setValue:[dict valueForKey:key] forKey:key];
        }
    }
}
```
