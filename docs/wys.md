## 位运算
### 判断最右位是不是1
数和1做与运算，因为1只有最后位为1其他位为0。
```
num & 1
```

### 除2右移一位
```
num >>= 1;
```
### 异或交换
``` java
// 异或交换，前提是i和j不指向同一内存地址
public static void swap2(int[] nums,int i,int j){
   nums[i] = nums[i] ^ nums[j];
   nums[j] = nums[i] ^ nums[j];
   nums[i] = nums[i] ^ nums[j];
}
```

### 得到最右为1的数字
公式=原码 & 补码
补码=原码取反 + 1
``` java
// 得到最右边为1的数字
int m = eor & (~eor +1);
```

### 计算中点值
左点加（右点-左点）/2
``` java
int mid = L + (R-L)>>1;
```