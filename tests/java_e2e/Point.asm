Compiled from "Point.java"
public class Point implements java.lang.AutoCloseable {
  public Point(java.lang.foreign.MemorySegment, java.lang.foreign.Arena);
    Code:
         0: aload_0
         1: invokespecial #1                  // Method java/lang/Object."<init>":()V
         4: aload_0
         5: aload_1
         6: putfield      #7                  // Field ptr:Ljava/lang/foreign/MemorySegment;
         9: aload_0
        10: aload_2
        11: putfield      #13                 // Field arena:Ljava/lang/foreign/Arena;
        14: return
      LineNumberTable:
        line 9: 0
        line 10: 4
        line 11: 9
        line 12: 14

  public java.lang.foreign.MemorySegment getPointer();
    Code:
         0: aload_0
         1: getfield      #7                  // Field ptr:Ljava/lang/foreign/MemorySegment;
         4: areturn
      LineNumberTable:
        line 14: 0

  public Point();
    Code:
         0: aload_0
         1: invokespecial #1                  // Method java/lang/Object."<init>":()V
         4: invokestatic  #70                 // InterfaceMethod java/lang/foreign/Arena.ofConfined:()Ljava/lang/foreign/Arena;
         7: astore_1
         8: aload_0
         9: getstatic     #76                 // Field mh_init_0:Ljava/lang/invoke/MethodHandle;
        12: invokevirtual #21                 // Method java/lang/invoke/MethodHandle.invokeExact:()Ljava/lang/foreign/MemorySegment;
        15: putfield      #7                  // Field ptr:Ljava/lang/foreign/MemorySegment;
        18: invokestatic  #79                 // Method checkError:()V
        21: aload_0
        22: invokestatic  #82                 // InterfaceMethod java/lang/foreign/Arena.ofAuto:()Ljava/lang/foreign/Arena;
        25: putfield      #13                 // Field arena:Ljava/lang/foreign/Arena;
        28: aload_1
        29: ifnull        63
        32: aload_1
        33: invokeinterface #85,  1           // InterfaceMethod java/lang/foreign/Arena.close:()V
        38: goto          63
        41: astore_2
        42: aload_1
        43: ifnull        61
        46: aload_1
        47: invokeinterface #85,  1           // InterfaceMethod java/lang/foreign/Arena.close:()V
        52: goto          61
        55: astore_3
        56: aload_2
        57: aload_3
        58: invokevirtual #88                 // Method java/lang/Throwable.addSuppressed:(Ljava/lang/Throwable;)V
        61: aload_2
        62: athrow
        63: goto          81
        66: astore_1
        67: aload_1
        68: athrow
        69: astore_1
        70: new           #54                 // class java/lang/RuntimeException
        73: dup
        74: ldc           #92                 // String Native constructor failed
        76: aload_1
        77: invokespecial #67                 // Method java/lang/RuntimeException."<init>":(Ljava/lang/String;Ljava/lang/Throwable;)V
        80: athrow
        81: return
      Exception table:
         from    to  target type
             8    28    41   Class java/lang/Throwable
            46    52    55   Class java/lang/Throwable
             4    63    66   Class java/lang/RuntimeException
             4    63    69   Class java/lang/Throwable
      LineNumberTable:
        line 147: 0
        line 149: 4
        line 150: 8
        line 151: 18
        line 152: 21
        line 153: 28
        line 149: 41
        line 156: 63
        line 154: 66
        line 155: 70
        line 157: 81

  public Point(int, int);
    Code:
         0: aload_0
         1: invokespecial #1                  // Method java/lang/Object."<init>":()V
         4: invokestatic  #70                 // InterfaceMethod java/lang/foreign/Arena.ofConfined:()Ljava/lang/foreign/Arena;
         7: astore_3
         8: aload_0
         9: getstatic     #94                 // Field mh_init_1:Ljava/lang/invoke/MethodHandle;
        12: iload_1
        13: iload_2
        14: invokevirtual #97                 // Method java/lang/invoke/MethodHandle.invokeExact:(II)Ljava/lang/foreign/MemorySegment;
        17: putfield      #7                  // Field ptr:Ljava/lang/foreign/MemorySegment;
        20: invokestatic  #79                 // Method checkError:()V
        23: aload_0
        24: invokestatic  #82                 // InterfaceMethod java/lang/foreign/Arena.ofAuto:()Ljava/lang/foreign/Arena;
        27: putfield      #13                 // Field arena:Ljava/lang/foreign/Arena;
        30: aload_3
        31: ifnull        70
        34: aload_3
        35: invokeinterface #85,  1           // InterfaceMethod java/lang/foreign/Arena.close:()V
        40: goto          70
        43: astore        4
        45: aload_3
        46: ifnull        67
        49: aload_3
        50: invokeinterface #85,  1           // InterfaceMethod java/lang/foreign/Arena.close:()V
        55: goto          67
        58: astore        5
        60: aload         4
        62: aload         5
        64: invokevirtual #88                 // Method java/lang/Throwable.addSuppressed:(Ljava/lang/Throwable;)V
        67: aload         4
        69: athrow
        70: goto          88
        73: astore_3
        74: aload_3
        75: athrow
        76: astore_3
        77: new           #54                 // class java/lang/RuntimeException
        80: dup
        81: ldc           #92                 // String Native constructor failed
        83: aload_3
        84: invokespecial #67                 // Method java/lang/RuntimeException."<init>":(Ljava/lang/String;Ljava/lang/Throwable;)V
        87: athrow
        88: return
      Exception table:
         from    to  target type
             8    30    43   Class java/lang/Throwable
            49    55    58   Class java/lang/Throwable
             4    70    73   Class java/lang/RuntimeException
             4    70    76   Class java/lang/Throwable
      LineNumberTable:
        line 159: 0
        line 161: 4
        line 162: 8
        line 163: 20
        line 164: 23
        line 165: 30
        line 161: 43
        line 168: 70
        line 166: 73
        line 167: 77
        line 169: 88

  public void print();
    Code:
         0: invokestatic  #70                 // InterfaceMethod java/lang/foreign/Arena.ofConfined:()Ljava/lang/foreign/Arena;
         3: astore_1
         4: getstatic     #100                // Field mh_print_0:Ljava/lang/invoke/MethodHandle;
         7: aload_0
         8: getfield      #7                  // Field ptr:Ljava/lang/foreign/MemorySegment;
        11: invokevirtual #103                // Method java/lang/invoke/MethodHandle.invokeExact:(Ljava/lang/foreign/MemorySegment;)V
        14: invokestatic  #79                 // Method checkError:()V
        17: aload_1
        18: ifnull        52
        21: aload_1
        22: invokeinterface #85,  1           // InterfaceMethod java/lang/foreign/Arena.close:()V
        27: goto          52
        30: astore_2
        31: aload_1
        32: ifnull        50
        35: aload_1
        36: invokeinterface #85,  1           // InterfaceMethod java/lang/foreign/Arena.close:()V
        41: goto          50
        44: astore_3
        45: aload_2
        46: aload_3
        47: invokevirtual #88                 // Method java/lang/Throwable.addSuppressed:(Ljava/lang/Throwable;)V
        50: aload_2
        51: athrow
        52: goto          70
        55: astore_1
        56: aload_1
        57: athrow
        58: astore_1
        59: new           #54                 // class java/lang/RuntimeException
        62: dup
        63: ldc           #106                // String Native call failed
        65: aload_1
        66: invokespecial #67                 // Method java/lang/RuntimeException."<init>":(Ljava/lang/String;Ljava/lang/Throwable;)V
        69: athrow
        70: return
      Exception table:
         from    to  target type
             4    17    30   Class java/lang/Throwable
            35    41    44   Class java/lang/Throwable
             0    52    55   Class java/lang/RuntimeException
             0    52    58   Class java/lang/Throwable
      LineNumberTable:
        line 173: 0
        line 174: 4
        line 175: 14
        line 176: 17
        line 173: 30
        line 179: 52
        line 177: 55
        line 178: 59
        line 180: 70

  public int add(int, int);
    Code:
         0: invokestatic  #70                 // InterfaceMethod java/lang/foreign/Arena.ofConfined:()Ljava/lang/foreign/Arena;
         3: astore_3
         4: getstatic     #108                // Field mh_add_1:Ljava/lang/invoke/MethodHandle;
         7: aload_0
         8: getfield      #7                  // Field ptr:Ljava/lang/foreign/MemorySegment;
        11: iload_1
        12: iload_2
        13: invokevirtual #111                // Method java/lang/invoke/MethodHandle.invokeExact:(Ljava/lang/foreign/MemorySegment;II)I
        16: istore        4
        18: invokestatic  #79                 // Method checkError:()V
        21: iload         4
        23: istore        5
        25: aload_3
        26: ifnull        35
        29: aload_3
        30: invokeinterface #85,  1           // InterfaceMethod java/lang/foreign/Arena.close:()V
        35: iload         5
        37: ireturn
        38: astore        4
        40: aload_3
        41: ifnull        62
        44: aload_3
        45: invokeinterface #85,  1           // InterfaceMethod java/lang/foreign/Arena.close:()V
        50: goto          62
        53: astore        5
        55: aload         4
        57: aload         5
        59: invokevirtual #88                 // Method java/lang/Throwable.addSuppressed:(Ljava/lang/Throwable;)V
        62: aload         4
        64: athrow
        65: astore_3
        66: aload_3
        67: athrow
        68: astore_3
        69: new           #54                 // class java/lang/RuntimeException
        72: dup
        73: ldc           #106                // String Native call failed
        75: aload_3
        76: invokespecial #67                 // Method java/lang/RuntimeException."<init>":(Ljava/lang/String;Ljava/lang/Throwable;)V
        79: athrow
      Exception table:
         from    to  target type
             4    25    38   Class java/lang/Throwable
            44    50    53   Class java/lang/Throwable
             0    35    65   Class java/lang/RuntimeException
            38    65    65   Class java/lang/RuntimeException
             0    35    68   Class java/lang/Throwable
            38    65    68   Class java/lang/Throwable
      LineNumberTable:
        line 184: 0
        line 185: 4
        line 186: 18
        line 187: 21
        line 188: 25
        line 187: 35
        line 184: 38
        line 189: 65
        line 190: 69

  public long multiplyUnsigned(long, long);
    Code:
         0: invokestatic  #70                 // InterfaceMethod java/lang/foreign/Arena.ofConfined:()Ljava/lang/foreign/Arena;
         3: astore        5
         5: getstatic     #114                // Field mh_multiplyUnsigned_2:Ljava/lang/invoke/MethodHandle;
         8: aload_0
         9: getfield      #7                  // Field ptr:Ljava/lang/foreign/MemorySegment;
        12: lload_1
        13: l2i
        14: lload_3
        15: l2i
        16: invokevirtual #111                // Method java/lang/invoke/MethodHandle.invokeExact:(Ljava/lang/foreign/MemorySegment;II)I
        19: istore        6
        21: invokestatic  #79                 // Method checkError:()V
        24: iload         6
        26: i2l
        27: ldc2_w        #117                // long 4294967295l
        30: land
        31: lstore        7
        33: aload         5
        35: ifnull        45
        38: aload         5
        40: invokeinterface #85,  1           // InterfaceMethod java/lang/foreign/Arena.close:()V
        45: lload         7
        47: lreturn
        48: astore        6
        50: aload         5
        52: ifnull        74
        55: aload         5
        57: invokeinterface #85,  1           // InterfaceMethod java/lang/foreign/Arena.close:()V
        62: goto          74
        65: astore        7
        67: aload         6
        69: aload         7
        71: invokevirtual #88                 // Method java/lang/Throwable.addSuppressed:(Ljava/lang/Throwable;)V
        74: aload         6
        76: athrow
        77: astore        5
        79: aload         5
        81: athrow
        82: astore        5
        84: new           #54                 // class java/lang/RuntimeException
        87: dup
        88: ldc           #106                // String Native call failed
        90: aload         5
        92: invokespecial #67                 // Method java/lang/RuntimeException."<init>":(Ljava/lang/String;Ljava/lang/Throwable;)V
        95: athrow
      Exception table:
         from    to  target type
             5    33    48   Class java/lang/Throwable
            55    62    65   Class java/lang/Throwable
             0    45    77   Class java/lang/RuntimeException
            48    77    77   Class java/lang/RuntimeException
             0    45    82   Class java/lang/Throwable
            48    77    82   Class java/lang/Throwable
      LineNumberTable:
        line 196: 0
        line 197: 5
        line 198: 21
        line 199: 24
        line 200: 33
        line 199: 45
        line 196: 48
        line 201: 77
        line 202: 84

  public void incReference(int[]);
    Code:
         0: invokestatic  #70                 // InterfaceMethod java/lang/foreign/Arena.ofConfined:()Ljava/lang/foreign/Arena;
         3: astore_2
         4: aload_2
         5: getstatic     #119                // Field java/lang/foreign/ValueLayout.JAVA_INT:Ljava/lang/foreign/ValueLayout$OfInt;
         8: aload_1
         9: invokeinterface #123,  3          // InterfaceMethod java/lang/foreign/Arena.allocateFrom:(Ljava/lang/foreign/ValueLayout$OfInt;[I)Ljava/lang/foreign/MemorySegment;
        14: astore_3
        15: getstatic     #127                // Field mh_incReference_3:Ljava/lang/invoke/MethodHandle;
        18: aload_0
        19: getfield      #7                  // Field ptr:Ljava/lang/foreign/MemorySegment;
        22: aload_3
        23: invokevirtual #130                // Method java/lang/invoke/MethodHandle.invokeExact:(Ljava/lang/foreign/MemorySegment;Ljava/lang/foreign/MemorySegment;)V
        26: invokestatic  #79                 // Method checkError:()V
        29: aload_3
        30: getstatic     #119                // Field java/lang/foreign/ValueLayout.JAVA_INT:Ljava/lang/foreign/ValueLayout$OfInt;
        33: lconst_0
        34: aload_1
        35: iconst_0
        36: aload_1
        37: arraylength
        38: invokestatic  #133                // InterfaceMethod java/lang/foreign/MemorySegment.copy:(Ljava/lang/foreign/MemorySegment;Ljava/lang/foreign/ValueLayout;JLjava/lang/Object;II)V
        41: aload_2
        42: ifnull        78
        45: aload_2
        46: invokeinterface #85,  1           // InterfaceMethod java/lang/foreign/Arena.close:()V
        51: goto          78
        54: astore_3
        55: aload_2
        56: ifnull        76
        59: aload_2
        60: invokeinterface #85,  1           // InterfaceMethod java/lang/foreign/Arena.close:()V
        65: goto          76
        68: astore        4
        70: aload_3
        71: aload         4
        73: invokevirtual #88                 // Method java/lang/Throwable.addSuppressed:(Ljava/lang/Throwable;)V
        76: aload_3
        77: athrow
        78: goto          96
        81: astore_2
        82: aload_2
        83: athrow
        84: astore_2
        85: new           #54                 // class java/lang/RuntimeException
        88: dup
        89: ldc           #106                // String Native call failed
        91: aload_2
        92: invokespecial #67                 // Method java/lang/RuntimeException."<init>":(Ljava/lang/String;Ljava/lang/Throwable;)V
        95: athrow
        96: return
      Exception table:
         from    to  target type
             4    41    54   Class java/lang/Throwable
            59    65    68   Class java/lang/Throwable
             0    78    81   Class java/lang/RuntimeException
             0    78    84   Class java/lang/Throwable
      LineNumberTable:
        line 208: 0
        line 209: 4
        line 210: 15
        line 211: 26
        line 212: 29
        line 213: 41
        line 208: 54
        line 216: 78
        line 214: 81
        line 215: 85
        line 217: 96

  public void crashMe();
    Code:
         0: invokestatic  #70                 // InterfaceMethod java/lang/foreign/Arena.ofConfined:()Ljava/lang/foreign/Arena;
         3: astore_1
         4: getstatic     #137                // Field mh_crashMe_4:Ljava/lang/invoke/MethodHandle;
         7: aload_0
         8: getfield      #7                  // Field ptr:Ljava/lang/foreign/MemorySegment;
        11: invokevirtual #103                // Method java/lang/invoke/MethodHandle.invokeExact:(Ljava/lang/foreign/MemorySegment;)V
        14: invokestatic  #79                 // Method checkError:()V
        17: aload_1
        18: ifnull        52
        21: aload_1
        22: invokeinterface #85,  1           // InterfaceMethod java/lang/foreign/Arena.close:()V
        27: goto          52
        30: astore_2
        31: aload_1
        32: ifnull        50
        35: aload_1
        36: invokeinterface #85,  1           // InterfaceMethod java/lang/foreign/Arena.close:()V
        41: goto          50
        44: astore_3
        45: aload_2
        46: aload_3
        47: invokevirtual #88                 // Method java/lang/Throwable.addSuppressed:(Ljava/lang/Throwable;)V
        50: aload_2
        51: athrow
        52: goto          70
        55: astore_1
        56: aload_1
        57: athrow
        58: astore_1
        59: new           #54                 // class java/lang/RuntimeException
        62: dup
        63: ldc           #106                // String Native call failed
        65: aload_1
        66: invokespecial #67                 // Method java/lang/RuntimeException."<init>":(Ljava/lang/String;Ljava/lang/Throwable;)V
        69: athrow
        70: return
      Exception table:
         from    to  target type
             4    17    30   Class java/lang/Throwable
            35    41    44   Class java/lang/Throwable
             0    52    55   Class java/lang/RuntimeException
             0    52    58   Class java/lang/Throwable
      LineNumberTable:
        line 221: 0
        line 222: 4
        line 223: 14
        line 224: 17
        line 221: 30
        line 227: 52
        line 225: 55
        line 226: 59
        line 228: 70

  public int get_x();
    Code:
         0: invokestatic  #70                 // InterfaceMethod java/lang/foreign/Arena.ofConfined:()Ljava/lang/foreign/Arena;
         3: astore_1
         4: getstatic     #140                // Field mh_get_x:Ljava/lang/invoke/MethodHandle;
         7: aload_0
         8: getfield      #7                  // Field ptr:Ljava/lang/foreign/MemorySegment;
        11: invokevirtual #143                // Method java/lang/invoke/MethodHandle.invokeExact:(Ljava/lang/foreign/MemorySegment;)I
        14: istore_2
        15: invokestatic  #79                 // Method checkError:()V
        18: iload_2
        19: istore_3
        20: aload_1
        21: ifnull        30
        24: aload_1
        25: invokeinterface #85,  1           // InterfaceMethod java/lang/foreign/Arena.close:()V
        30: iload_3
        31: ireturn
        32: astore_2
        33: aload_1
        34: ifnull        52
        37: aload_1
        38: invokeinterface #85,  1           // InterfaceMethod java/lang/foreign/Arena.close:()V
        43: goto          52
        46: astore_3
        47: aload_2
        48: aload_3
        49: invokevirtual #88                 // Method java/lang/Throwable.addSuppressed:(Ljava/lang/Throwable;)V
        52: aload_2
        53: athrow
        54: astore_1
        55: aload_1
        56: athrow
        57: astore_1
        58: new           #54                 // class java/lang/RuntimeException
        61: dup
        62: ldc           #146                // String Native field get failed
        64: aload_1
        65: invokespecial #67                 // Method java/lang/RuntimeException."<init>":(Ljava/lang/String;Ljava/lang/Throwable;)V
        68: athrow
      Exception table:
         from    to  target type
             4    20    32   Class java/lang/Throwable
            37    43    46   Class java/lang/Throwable
             0    30    54   Class java/lang/RuntimeException
            32    54    54   Class java/lang/RuntimeException
             0    30    57   Class java/lang/Throwable
            32    54    57   Class java/lang/Throwable
      LineNumberTable:
        line 232: 0
        line 233: 4
        line 234: 15
        line 235: 18
        line 236: 20
        line 235: 30
        line 232: 32
        line 237: 54
        line 238: 58

  public void set_x(int);
    Code:
         0: getstatic     #148                // Field mh_set_x:Ljava/lang/invoke/MethodHandle;
         3: ifnonnull     16
         6: new           #151                // class java/lang/UnsupportedOperationException
         9: dup
        10: ldc           #153                // String Field is const
        12: invokespecial #155                // Method java/lang/UnsupportedOperationException."<init>":(Ljava/lang/String;)V
        15: athrow
        16: invokestatic  #70                 // InterfaceMethod java/lang/foreign/Arena.ofConfined:()Ljava/lang/foreign/Arena;
        19: astore_2
        20: getstatic     #148                // Field mh_set_x:Ljava/lang/invoke/MethodHandle;
        23: aload_0
        24: getfield      #7                  // Field ptr:Ljava/lang/foreign/MemorySegment;
        27: iload_1
        28: invokevirtual #156                // Method java/lang/invoke/MethodHandle.invokeExact:(Ljava/lang/foreign/MemorySegment;I)V
        31: invokestatic  #79                 // Method checkError:()V
        34: aload_2
        35: ifnull        71
        38: aload_2
        39: invokeinterface #85,  1           // InterfaceMethod java/lang/foreign/Arena.close:()V
        44: goto          71
        47: astore_3
        48: aload_2
        49: ifnull        69
        52: aload_2
        53: invokeinterface #85,  1           // InterfaceMethod java/lang/foreign/Arena.close:()V
        58: goto          69
        61: astore        4
        63: aload_3
        64: aload         4
        66: invokevirtual #88                 // Method java/lang/Throwable.addSuppressed:(Ljava/lang/Throwable;)V
        69: aload_3
        70: athrow
        71: goto          89
        74: astore_2
        75: aload_2
        76: athrow
        77: astore_2
        78: new           #54                 // class java/lang/RuntimeException
        81: dup
        82: ldc           #159                // String Native field set failed
        84: aload_2
        85: invokespecial #67                 // Method java/lang/RuntimeException."<init>":(Ljava/lang/String;Ljava/lang/Throwable;)V
        88: athrow
        89: return
      Exception table:
         from    to  target type
            20    34    47   Class java/lang/Throwable
            52    58    61   Class java/lang/Throwable
             0    71    74   Class java/lang/RuntimeException
             0    71    77   Class java/lang/Throwable
      LineNumberTable:
        line 244: 0
        line 245: 16
        line 246: 20
        line 247: 31
        line 248: 34
        line 245: 47
        line 251: 71
        line 249: 74
        line 250: 78
        line 252: 89

  public int get_y();
    Code:
         0: invokestatic  #70                 // InterfaceMethod java/lang/foreign/Arena.ofConfined:()Ljava/lang/foreign/Arena;
         3: astore_1
         4: getstatic     #161                // Field mh_get_y:Ljava/lang/invoke/MethodHandle;
         7: aload_0
         8: getfield      #7                  // Field ptr:Ljava/lang/foreign/MemorySegment;
        11: invokevirtual #143                // Method java/lang/invoke/MethodHandle.invokeExact:(Ljava/lang/foreign/MemorySegment;)I
        14: istore_2
        15: invokestatic  #79                 // Method checkError:()V
        18: iload_2
        19: istore_3
        20: aload_1
        21: ifnull        30
        24: aload_1
        25: invokeinterface #85,  1           // InterfaceMethod java/lang/foreign/Arena.close:()V
        30: iload_3
        31: ireturn
        32: astore_2
        33: aload_1
        34: ifnull        52
        37: aload_1
        38: invokeinterface #85,  1           // InterfaceMethod java/lang/foreign/Arena.close:()V
        43: goto          52
        46: astore_3
        47: aload_2
        48: aload_3
        49: invokevirtual #88                 // Method java/lang/Throwable.addSuppressed:(Ljava/lang/Throwable;)V
        52: aload_2
        53: athrow
        54: astore_1
        55: aload_1
        56: athrow
        57: astore_1
        58: new           #54                 // class java/lang/RuntimeException
        61: dup
        62: ldc           #146                // String Native field get failed
        64: aload_1
        65: invokespecial #67                 // Method java/lang/RuntimeException."<init>":(Ljava/lang/String;Ljava/lang/Throwable;)V
        68: athrow
      Exception table:
         from    to  target type
             4    20    32   Class java/lang/Throwable
            37    43    46   Class java/lang/Throwable
             0    30    54   Class java/lang/RuntimeException
            32    54    54   Class java/lang/RuntimeException
             0    30    57   Class java/lang/Throwable
            32    54    57   Class java/lang/Throwable
      LineNumberTable:
        line 256: 0
        line 257: 4
        line 258: 15
        line 259: 18
        line 260: 20
        line 259: 30
        line 256: 32
        line 261: 54
        line 262: 58

  public void set_y(int);
    Code:
         0: getstatic     #164                // Field mh_set_y:Ljava/lang/invoke/MethodHandle;
         3: ifnonnull     16
         6: new           #151                // class java/lang/UnsupportedOperationException
         9: dup
        10: ldc           #153                // String Field is const
        12: invokespecial #155                // Method java/lang/UnsupportedOperationException."<init>":(Ljava/lang/String;)V
        15: athrow
        16: invokestatic  #70                 // InterfaceMethod java/lang/foreign/Arena.ofConfined:()Ljava/lang/foreign/Arena;
        19: astore_2
        20: getstatic     #164                // Field mh_set_y:Ljava/lang/invoke/MethodHandle;
        23: aload_0
        24: getfield      #7                  // Field ptr:Ljava/lang/foreign/MemorySegment;
        27: iload_1
        28: invokevirtual #156                // Method java/lang/invoke/MethodHandle.invokeExact:(Ljava/lang/foreign/MemorySegment;I)V
        31: invokestatic  #79                 // Method checkError:()V
        34: aload_2
        35: ifnull        71
        38: aload_2
        39: invokeinterface #85,  1           // InterfaceMethod java/lang/foreign/Arena.close:()V
        44: goto          71
        47: astore_3
        48: aload_2
        49: ifnull        69
        52: aload_2
        53: invokeinterface #85,  1           // InterfaceMethod java/lang/foreign/Arena.close:()V
        58: goto          69
        61: astore        4
        63: aload_3
        64: aload         4
        66: invokevirtual #88                 // Method java/lang/Throwable.addSuppressed:(Ljava/lang/Throwable;)V
        69: aload_3
        70: athrow
        71: goto          89
        74: astore_2
        75: aload_2
        76: athrow
        77: astore_2
        78: new           #54                 // class java/lang/RuntimeException
        81: dup
        82: ldc           #159                // String Native field set failed
        84: aload_2
        85: invokespecial #67                 // Method java/lang/RuntimeException."<init>":(Ljava/lang/String;Ljava/lang/Throwable;)V
        88: athrow
        89: return
      Exception table:
         from    to  target type
            20    34    47   Class java/lang/Throwable
            52    58    61   Class java/lang/Throwable
             0    71    74   Class java/lang/RuntimeException
             0    71    77   Class java/lang/Throwable
      LineNumberTable:
        line 268: 0
        line 269: 16
        line 270: 20
        line 271: 31
        line 272: 34
        line 269: 47
        line 275: 71
        line 273: 74
        line 274: 78
        line 276: 89

  public void close();
    Code:
         0: getstatic     #167                // Field mh_dtor:Ljava/lang/invoke/MethodHandle;
         3: aload_0
         4: getfield      #7                  // Field ptr:Ljava/lang/foreign/MemorySegment;
         7: invokevirtual #103                // Method java/lang/invoke/MethodHandle.invokeExact:(Ljava/lang/foreign/MemorySegment;)V
        10: goto          25
        13: astore_1
        14: new           #54                 // class java/lang/RuntimeException
        17: dup
        18: ldc           #170                // String Destructor failed
        20: aload_1
        21: invokespecial #67                 // Method java/lang/RuntimeException."<init>":(Ljava/lang/String;Ljava/lang/Throwable;)V
        24: athrow
        25: return
      Exception table:
         from    to  target type
             0    10    13   Class java/lang/Throwable
      LineNumberTable:
        line 281: 0
        line 284: 10
        line 282: 13
        line 283: 14
        line 285: 25

  static {};
    Code:
         0: invokestatic  #172                // InterfaceMethod java/lang/foreign/Linker.nativeLinker:()Ljava/lang/foreign/Linker;
         3: putstatic     #178                // Field LINKER:Ljava/lang/foreign/Linker;
         6: ldc           #182                // String JavaNativeLinkTest
         8: invokestatic  #184                // Method java/lang/System.loadLibrary:(Ljava/lang/String;)V
        11: invokestatic  #189                // InterfaceMethod java/lang/foreign/SymbolLookup.loaderLookup:()Ljava/lang/foreign/SymbolLookup;
        14: putstatic     #195                // Field LOOKUP:Ljava/lang/foreign/SymbolLookup;
        17: getstatic     #178                // Field LINKER:Ljava/lang/foreign/Linker;
        20: getstatic     #195                // Field LOOKUP:Ljava/lang/foreign/SymbolLookup;
        23: ldc           #199                // String JNL_GetLastError
        25: invokeinterface #201,  2          // InterfaceMethod java/lang/foreign/SymbolLookup.find:(Ljava/lang/String;)Ljava/util/Optional;
        30: invokevirtual #205                // Method java/util/Optional.orElseThrow:()Ljava/lang/Object;
        33: checkcast     #30                 // class java/lang/foreign/MemorySegment
        36: getstatic     #211                // Field java/lang/foreign/ValueLayout.ADDRESS:Ljava/lang/foreign/AddressLayout;
        39: iconst_0
        40: anewarray     #215                // class java/lang/foreign/MemoryLayout
        43: invokestatic  #217                // InterfaceMethod java/lang/foreign/FunctionDescriptor.of:(Ljava/lang/foreign/MemoryLayout;[Ljava/lang/foreign/MemoryLayout;)Ljava/lang/foreign/FunctionDescriptor;
        46: iconst_0
        47: anewarray     #223                // class java/lang/foreign/Linker$Option
        50: invokeinterface #225,  4          // InterfaceMethod java/lang/foreign/Linker.downcallHandle:(Ljava/lang/foreign/MemorySegment;Ljava/lang/foreign/FunctionDescriptor;[Ljava/lang/foreign/Linker$Option;)Ljava/lang/invoke/MethodHandle;
        55: putstatic     #17                 // Field mh_getLastError:Ljava/lang/invoke/MethodHandle;
        58: getstatic     #178                // Field LINKER:Ljava/lang/foreign/Linker;
        61: getstatic     #195                // Field LOOKUP:Ljava/lang/foreign/SymbolLookup;
        64: ldc           #229                // String JNL_ClearLastError
        66: invokeinterface #201,  2          // InterfaceMethod java/lang/foreign/SymbolLookup.find:(Ljava/lang/String;)Ljava/util/Optional;
        71: invokevirtual #205                // Method java/util/Optional.orElseThrow:()Ljava/lang/Object;
        74: checkcast     #30                 // class java/lang/foreign/MemorySegment
        77: iconst_0
        78: anewarray     #215                // class java/lang/foreign/MemoryLayout
        81: invokestatic  #231                // InterfaceMethod java/lang/foreign/FunctionDescriptor.ofVoid:([Ljava/lang/foreign/MemoryLayout;)Ljava/lang/foreign/FunctionDescriptor;
        84: iconst_0
        85: anewarray     #223                // class java/lang/foreign/Linker$Option
        88: invokeinterface #225,  4          // InterfaceMethod java/lang/foreign/Linker.downcallHandle:(Ljava/lang/foreign/MemorySegment;Ljava/lang/foreign/FunctionDescriptor;[Ljava/lang/foreign/Linker$Option;)Ljava/lang/invoke/MethodHandle;
        93: putstatic     #49                 // Field mh_clearLastError:Ljava/lang/invoke/MethodHandle;
        96: getstatic     #178                // Field LINKER:Ljava/lang/foreign/Linker;
        99: getstatic     #195                // Field LOOKUP:Ljava/lang/foreign/SymbolLookup;
       102: ldc           #235                // String JNL_GetRegistry
       104: invokeinterface #201,  2          // InterfaceMethod java/lang/foreign/SymbolLookup.find:(Ljava/lang/String;)Ljava/util/Optional;
       109: invokevirtual #205                // Method java/util/Optional.orElseThrow:()Ljava/lang/Object;
       112: checkcast     #30                 // class java/lang/foreign/MemorySegment
       115: getstatic     #211                // Field java/lang/foreign/ValueLayout.ADDRESS:Ljava/lang/foreign/AddressLayout;
       118: iconst_1
       119: anewarray     #215                // class java/lang/foreign/MemoryLayout
       122: dup
       123: iconst_0
       124: getstatic     #211                // Field java/lang/foreign/ValueLayout.ADDRESS:Ljava/lang/foreign/AddressLayout;
       127: aastore
       128: invokestatic  #217                // InterfaceMethod java/lang/foreign/FunctionDescriptor.of:(Ljava/lang/foreign/MemoryLayout;[Ljava/lang/foreign/MemoryLayout;)Ljava/lang/foreign/FunctionDescriptor;
       131: iconst_0
       132: anewarray     #223                // class java/lang/foreign/Linker$Option
       135: invokeinterface #225,  4          // InterfaceMethod java/lang/foreign/Linker.downcallHandle:(Ljava/lang/foreign/MemorySegment;Ljava/lang/foreign/FunctionDescriptor;[Ljava/lang/foreign/Linker$Option;)Ljava/lang/invoke/MethodHandle;
       140: astore_0
       141: invokestatic  #70                 // InterfaceMethod java/lang/foreign/Arena.ofConfined:()Ljava/lang/foreign/Arena;
       144: astore_1
       145: aload_1
       146: ldc           #237                // String Point
       148: invokeinterface #238,  2          // InterfaceMethod java/lang/foreign/Arena.allocateFrom:(Ljava/lang/String;)Ljava/lang/foreign/MemorySegment;
       153: astore_2
       154: aload_0
       155: aload_2
       156: invokevirtual #241                // Method java/lang/invoke/MethodHandle.invokeExact:(Ljava/lang/foreign/MemorySegment;)Ljava/lang/foreign/MemorySegment;
       159: astore_3
       160: aload_3
       161: getstatic     #244                // Field java/lang/foreign/MemorySegment.NULL:Ljava/lang/foreign/MemorySegment;
       164: invokeinterface #247,  2          // InterfaceMethod java/lang/foreign/MemorySegment.equals:(Ljava/lang/Object;)Z
       169: ifeq          182
       172: new           #54                 // class java/lang/RuntimeException
       175: dup
       176: ldc           #251                // String Registry not found for Point
       178: invokespecial #60                 // Method java/lang/RuntimeException."<init>":(Ljava/lang/String;)V
       181: athrow
       182: aload_3
       183: ldc2_w        #253                // long 64l
       186: invokeinterface #29,  3           // InterfaceMethod java/lang/foreign/MemorySegment.reinterpret:(J)Ljava/lang/foreign/MemorySegment;
       191: astore_3
       192: aload_3
       193: getstatic     #211                // Field java/lang/foreign/ValueLayout.ADDRESS:Ljava/lang/foreign/AddressLayout;
       196: ldc2_w        #255                // long 8l
       199: invokeinterface #257,  4          // InterfaceMethod java/lang/foreign/MemorySegment.get:(Ljava/lang/foreign/AddressLayout;J)Ljava/lang/foreign/MemorySegment;
       204: astore        4
       206: aload_3
       207: getstatic     #260                // Field java/lang/foreign/ValueLayout.JAVA_LONG:Ljava/lang/foreign/ValueLayout$OfLong;
       210: ldc2_w        #264                // long 16l
       213: invokeinterface #266,  4          // InterfaceMethod java/lang/foreign/MemorySegment.get:(Ljava/lang/foreign/ValueLayout$OfLong;J)J
       218: lstore        5
       220: aload         4
       222: lload         5
       224: ldc2_w        #264                // long 16l
       227: lmul
       228: invokeinterface #29,  3           // InterfaceMethod java/lang/foreign/MemorySegment.reinterpret:(J)Ljava/lang/foreign/MemorySegment;
       233: astore        4
       235: lconst_0
       236: lstore        7
       238: lload         7
       240: lload         5
       242: lcmp
       243: ifge          590
       246: aload         4
       248: lload         7
       250: ldc2_w        #264                // long 16l
       253: lmul
       254: ldc2_w        #264                // long 16l
       257: invokeinterface #269,  5          // InterfaceMethod java/lang/foreign/MemorySegment.asSlice:(JJ)Ljava/lang/foreign/MemorySegment;
       262: astore        9
       264: aload         9
       266: getstatic     #211                // Field java/lang/foreign/ValueLayout.ADDRESS:Ljava/lang/foreign/AddressLayout;
       269: lconst_0
       270: invokeinterface #257,  4          // InterfaceMethod java/lang/foreign/MemorySegment.get:(Ljava/lang/foreign/AddressLayout;J)Ljava/lang/foreign/MemorySegment;
       275: ldc2_w        #273                // long 1024l
       278: invokeinterface #29,  3           // InterfaceMethod java/lang/foreign/MemorySegment.reinterpret:(J)Ljava/lang/foreign/MemorySegment;
       283: astore        10
       285: aload         9
       287: getstatic     #211                // Field java/lang/foreign/ValueLayout.ADDRESS:Ljava/lang/foreign/AddressLayout;
       290: ldc2_w        #255                // long 8l
       293: invokeinterface #257,  4          // InterfaceMethod java/lang/foreign/MemorySegment.get:(Ljava/lang/foreign/AddressLayout;J)Ljava/lang/foreign/MemorySegment;
       298: astore        11
       300: aload         10
       302: lconst_0
       303: invokeinterface #45,  3           // InterfaceMethod java/lang/foreign/MemorySegment.getString:(J)Ljava/lang/String;
       308: astore        12
       310: aload         12
       312: ldc_w         #275                // String print
       315: invokevirtual #277                // Method java/lang/String.equals:(Ljava/lang/Object;)Z
       318: ifeq          357
       321: getstatic     #100                // Field mh_print_0:Ljava/lang/invoke/MethodHandle;
       324: ifnonnull     357
       327: getstatic     #178                // Field LINKER:Ljava/lang/foreign/Linker;
       330: aload         11
       332: iconst_1
       333: anewarray     #215                // class java/lang/foreign/MemoryLayout
       336: dup
       337: iconst_0
       338: getstatic     #211                // Field java/lang/foreign/ValueLayout.ADDRESS:Ljava/lang/foreign/AddressLayout;
       341: aastore
       342: invokestatic  #231                // InterfaceMethod java/lang/foreign/FunctionDescriptor.ofVoid:([Ljava/lang/foreign/MemoryLayout;)Ljava/lang/foreign/FunctionDescriptor;
       345: iconst_0
       346: anewarray     #223                // class java/lang/foreign/Linker$Option
       349: invokeinterface #225,  4          // InterfaceMethod java/lang/foreign/Linker.downcallHandle:(Ljava/lang/foreign/MemorySegment;Ljava/lang/foreign/FunctionDescriptor;[Ljava/lang/foreign/Linker$Option;)Ljava/lang/invoke/MethodHandle;
       354: putstatic     #100                // Field mh_print_0:Ljava/lang/invoke/MethodHandle;
       357: aload         12
       359: ldc_w         #280                // String add
       362: invokevirtual #277                // Method java/lang/String.equals:(Ljava/lang/Object;)Z
       365: ifeq          419
       368: getstatic     #108                // Field mh_add_1:Ljava/lang/invoke/MethodHandle;
       371: ifnonnull     419
       374: getstatic     #178                // Field LINKER:Ljava/lang/foreign/Linker;
       377: aload         11
       379: getstatic     #119                // Field java/lang/foreign/ValueLayout.JAVA_INT:Ljava/lang/foreign/ValueLayout$OfInt;
       382: iconst_3
       383: anewarray     #215                // class java/lang/foreign/MemoryLayout
       386: dup
       387: iconst_0
       388: getstatic     #211                // Field java/lang/foreign/ValueLayout.ADDRESS:Ljava/lang/foreign/AddressLayout;
       391: aastore
       392: dup
       393: iconst_1
       394: getstatic     #119                // Field java/lang/foreign/ValueLayout.JAVA_INT:Ljava/lang/foreign/ValueLayout$OfInt;
       397: aastore
       398: dup
       399: iconst_2
       400: getstatic     #119                // Field java/lang/foreign/ValueLayout.JAVA_INT:Ljava/lang/foreign/ValueLayout$OfInt;
       403: aastore
       404: invokestatic  #217                // InterfaceMethod java/lang/foreign/FunctionDescriptor.of:(Ljava/lang/foreign/MemoryLayout;[Ljava/lang/foreign/MemoryLayout;)Ljava/lang/foreign/FunctionDescriptor;
       407: iconst_0
       408: anewarray     #223                // class java/lang/foreign/Linker$Option
       411: invokeinterface #225,  4          // InterfaceMethod java/lang/foreign/Linker.downcallHandle:(Ljava/lang/foreign/MemorySegment;Ljava/lang/foreign/FunctionDescriptor;[Ljava/lang/foreign/Linker$Option;)Ljava/lang/invoke/MethodHandle;
       416: putstatic     #108                // Field mh_add_1:Ljava/lang/invoke/MethodHandle;
       419: aload         12
       421: ldc_w         #282                // String multiplyUnsigned
       424: invokevirtual #277                // Method java/lang/String.equals:(Ljava/lang/Object;)Z
       427: ifeq          481
       430: getstatic     #114                // Field mh_multiplyUnsigned_2:Ljava/lang/invoke/MethodHandle;
       433: ifnonnull     481
       436: getstatic     #178                // Field LINKER:Ljava/lang/foreign/Linker;
       439: aload         11
       441: getstatic     #119                // Field java/lang/foreign/ValueLayout.JAVA_INT:Ljava/lang/foreign/ValueLayout$OfInt;
       444: iconst_3
       445: anewarray     #215                // class java/lang/foreign/MemoryLayout
       448: dup
       449: iconst_0
       450: getstatic     #211                // Field java/lang/foreign/ValueLayout.ADDRESS:Ljava/lang/foreign/AddressLayout;
       453: aastore
       454: dup
       455: iconst_1
       456: getstatic     #119                // Field java/lang/foreign/ValueLayout.JAVA_INT:Ljava/lang/foreign/ValueLayout$OfInt;
       459: aastore
       460: dup
       461: iconst_2
       462: getstatic     #119                // Field java/lang/foreign/ValueLayout.JAVA_INT:Ljava/lang/foreign/ValueLayout$OfInt;
       465: aastore
       466: invokestatic  #217                // InterfaceMethod java/lang/foreign/FunctionDescriptor.of:(Ljava/lang/foreign/MemoryLayout;[Ljava/lang/foreign/MemoryLayout;)Ljava/lang/foreign/FunctionDescriptor;
       469: iconst_0
       470: anewarray     #223                // class java/lang/foreign/Linker$Option
       473: invokeinterface #225,  4          // InterfaceMethod java/lang/foreign/Linker.downcallHandle:(Ljava/lang/foreign/MemorySegment;Ljava/lang/foreign/FunctionDescriptor;[Ljava/lang/foreign/Linker$Option;)Ljava/lang/invoke/MethodHandle;
       478: putstatic     #114                // Field mh_multiplyUnsigned_2:Ljava/lang/invoke/MethodHandle;
       481: aload         12
       483: ldc_w         #284                // String incReference
       486: invokevirtual #277                // Method java/lang/String.equals:(Ljava/lang/Object;)Z
       489: ifeq          534
       492: getstatic     #127                // Field mh_incReference_3:Ljava/lang/invoke/MethodHandle;
       495: ifnonnull     534
       498: getstatic     #178                // Field LINKER:Ljava/lang/foreign/Linker;
       501: aload         11
       503: iconst_2
       504: anewarray     #215                // class java/lang/foreign/MemoryLayout
       507: dup
       508: iconst_0
       509: getstatic     #211                // Field java/lang/foreign/ValueLayout.ADDRESS:Ljava/lang/foreign/AddressLayout;
       512: aastore
       513: dup
       514: iconst_1
       515: getstatic     #211                // Field java/lang/foreign/ValueLayout.ADDRESS:Ljava/lang/foreign/AddressLayout;
       518: aastore
       519: invokestatic  #231                // InterfaceMethod java/lang/foreign/FunctionDescriptor.ofVoid:([Ljava/lang/foreign/MemoryLayout;)Ljava/lang/foreign/FunctionDescriptor;
       522: iconst_0
       523: anewarray     #223                // class java/lang/foreign/Linker$Option
       526: invokeinterface #225,  4          // InterfaceMethod java/lang/foreign/Linker.downcallHandle:(Ljava/lang/foreign/MemorySegment;Ljava/lang/foreign/FunctionDescriptor;[Ljava/lang/foreign/Linker$Option;)Ljava/lang/invoke/MethodHandle;
       531: putstatic     #127                // Field mh_incReference_3:Ljava/lang/invoke/MethodHandle;
       534: aload         12
       536: ldc_w         #286                // String crashMe
       539: invokevirtual #277                // Method java/lang/String.equals:(Ljava/lang/Object;)Z
       542: ifeq          581
       545: getstatic     #137                // Field mh_crashMe_4:Ljava/lang/invoke/MethodHandle;
       548: ifnonnull     581
       551: getstatic     #178                // Field LINKER:Ljava/lang/foreign/Linker;
       554: aload         11
       556: iconst_1
       557: anewarray     #215                // class java/lang/foreign/MemoryLayout
       560: dup
       561: iconst_0
       562: getstatic     #211                // Field java/lang/foreign/ValueLayout.ADDRESS:Ljava/lang/foreign/AddressLayout;
       565: aastore
       566: invokestatic  #231                // InterfaceMethod java/lang/foreign/FunctionDescriptor.ofVoid:([Ljava/lang/foreign/MemoryLayout;)Ljava/lang/foreign/FunctionDescriptor;
       569: iconst_0
       570: anewarray     #223                // class java/lang/foreign/Linker$Option
       573: invokeinterface #225,  4          // InterfaceMethod java/lang/foreign/Linker.downcallHandle:(Ljava/lang/foreign/MemorySegment;Ljava/lang/foreign/FunctionDescriptor;[Ljava/lang/foreign/Linker$Option;)Ljava/lang/invoke/MethodHandle;
       578: putstatic     #137                // Field mh_crashMe_4:Ljava/lang/invoke/MethodHandle;
       581: lload         7
       583: lconst_1
       584: ladd
       585: lstore        7
       587: goto          238
       590: aload_3
       591: getstatic     #211                // Field java/lang/foreign/ValueLayout.ADDRESS:Ljava/lang/foreign/AddressLayout;
       594: ldc2_w        #288                // long 24l
       597: invokeinterface #257,  4          // InterfaceMethod java/lang/foreign/MemorySegment.get:(Ljava/lang/foreign/AddressLayout;J)Ljava/lang/foreign/MemorySegment;
       602: astore        7
       604: aload_3
       605: getstatic     #260                // Field java/lang/foreign/ValueLayout.JAVA_LONG:Ljava/lang/foreign/ValueLayout$OfLong;
       608: ldc2_w        #290                // long 32l
       611: invokeinterface #266,  4          // InterfaceMethod java/lang/foreign/MemorySegment.get:(Ljava/lang/foreign/ValueLayout$OfLong;J)J
       616: lstore        8
       618: aload         7
       620: lload         8
       622: ldc2_w        #264                // long 16l
       625: lmul
       626: invokeinterface #29,  3           // InterfaceMethod java/lang/foreign/MemorySegment.reinterpret:(J)Ljava/lang/foreign/MemorySegment;
       631: astore        7
       633: lconst_0
       634: lstore        10
       636: lload         10
       638: lload         8
       640: lcmp
       641: ifge          766
       644: aload         7
       646: lload         10
       648: ldc2_w        #264                // long 16l
       651: lmul
       652: ldc2_w        #264                // long 16l
       655: invokeinterface #269,  5          // InterfaceMethod java/lang/foreign/MemorySegment.asSlice:(JJ)Ljava/lang/foreign/MemorySegment;
       660: astore        12
       662: aload         12
       664: getstatic     #211                // Field java/lang/foreign/ValueLayout.ADDRESS:Ljava/lang/foreign/AddressLayout;
       667: ldc2_w        #255                // long 8l
       670: invokeinterface #257,  4          // InterfaceMethod java/lang/foreign/MemorySegment.get:(Ljava/lang/foreign/AddressLayout;J)Ljava/lang/foreign/MemorySegment;
       675: astore        13
       677: lload         10
       679: lconst_0
       680: lcmp
       681: ifne          711
       684: getstatic     #178                // Field LINKER:Ljava/lang/foreign/Linker;
       687: aload         13
       689: getstatic     #211                // Field java/lang/foreign/ValueLayout.ADDRESS:Ljava/lang/foreign/AddressLayout;
       692: iconst_0
       693: anewarray     #215                // class java/lang/foreign/MemoryLayout
       696: invokestatic  #217                // InterfaceMethod java/lang/foreign/FunctionDescriptor.of:(Ljava/lang/foreign/MemoryLayout;[Ljava/lang/foreign/MemoryLayout;)Ljava/lang/foreign/FunctionDescriptor;
       699: iconst_0
       700: anewarray     #223                // class java/lang/foreign/Linker$Option
       703: invokeinterface #225,  4          // InterfaceMethod java/lang/foreign/Linker.downcallHandle:(Ljava/lang/foreign/MemorySegment;Ljava/lang/foreign/FunctionDescriptor;[Ljava/lang/foreign/Linker$Option;)Ljava/lang/invoke/MethodHandle;
       708: putstatic     #76                 // Field mh_init_0:Ljava/lang/invoke/MethodHandle;
       711: lload         10
       713: lconst_1
       714: lcmp
       715: ifne          757
       718: getstatic     #178                // Field LINKER:Ljava/lang/foreign/Linker;
       721: aload         13
       723: getstatic     #211                // Field java/lang/foreign/ValueLayout.ADDRESS:Ljava/lang/foreign/AddressLayout;
       726: iconst_2
       727: anewarray     #215                // class java/lang/foreign/MemoryLayout
       730: dup
       731: iconst_0
       732: getstatic     #119                // Field java/lang/foreign/ValueLayout.JAVA_INT:Ljava/lang/foreign/ValueLayout$OfInt;
       735: aastore
       736: dup
       737: iconst_1
       738: getstatic     #119                // Field java/lang/foreign/ValueLayout.JAVA_INT:Ljava/lang/foreign/ValueLayout$OfInt;
       741: aastore
       742: invokestatic  #217                // InterfaceMethod java/lang/foreign/FunctionDescriptor.of:(Ljava/lang/foreign/MemoryLayout;[Ljava/lang/foreign/MemoryLayout;)Ljava/lang/foreign/FunctionDescriptor;
       745: iconst_0
       746: anewarray     #223                // class java/lang/foreign/Linker$Option
       749: invokeinterface #225,  4          // InterfaceMethod java/lang/foreign/Linker.downcallHandle:(Ljava/lang/foreign/MemorySegment;Ljava/lang/foreign/FunctionDescriptor;[Ljava/lang/foreign/Linker$Option;)Ljava/lang/invoke/MethodHandle;
       754: putstatic     #94                 // Field mh_init_1:Ljava/lang/invoke/MethodHandle;
       757: lload         10
       759: lconst_1
       760: ladd
       761: lstore        10
       763: goto          636
       766: aload_3
       767: getstatic     #211                // Field java/lang/foreign/ValueLayout.ADDRESS:Ljava/lang/foreign/AddressLayout;
       770: ldc2_w        #292                // long 48l
       773: invokeinterface #257,  4          // InterfaceMethod java/lang/foreign/MemorySegment.get:(Ljava/lang/foreign/AddressLayout;J)Ljava/lang/foreign/MemorySegment;
       778: astore        10
       780: aload_3
       781: getstatic     #260                // Field java/lang/foreign/ValueLayout.JAVA_LONG:Ljava/lang/foreign/ValueLayout$OfLong;
       784: ldc2_w        #294                // long 56l
       787: invokeinterface #266,  4          // InterfaceMethod java/lang/foreign/MemorySegment.get:(Ljava/lang/foreign/ValueLayout$OfLong;J)J
       792: lstore        11
       794: aload         10
       796: lload         11
       798: ldc2_w        #288                // long 24l
       801: lmul
       802: invokeinterface #29,  3           // InterfaceMethod java/lang/foreign/MemorySegment.reinterpret:(J)Ljava/lang/foreign/MemorySegment;
       807: astore        10
       809: lconst_0
       810: lstore        13
       812: lload         13
       814: lload         11
       816: lcmp
       817: ifge          1106
       820: aload         10
       822: lload         13
       824: ldc2_w        #288                // long 24l
       827: lmul
       828: ldc2_w        #288                // long 24l
       831: invokeinterface #269,  5          // InterfaceMethod java/lang/foreign/MemorySegment.asSlice:(JJ)Ljava/lang/foreign/MemorySegment;
       836: astore        15
       838: aload         15
       840: getstatic     #211                // Field java/lang/foreign/ValueLayout.ADDRESS:Ljava/lang/foreign/AddressLayout;
       843: lconst_0
       844: invokeinterface #257,  4          // InterfaceMethod java/lang/foreign/MemorySegment.get:(Ljava/lang/foreign/AddressLayout;J)Ljava/lang/foreign/MemorySegment;
       849: ldc2_w        #273                // long 1024l
       852: invokeinterface #29,  3           // InterfaceMethod java/lang/foreign/MemorySegment.reinterpret:(J)Ljava/lang/foreign/MemorySegment;
       857: astore        16
       859: aload         15
       861: getstatic     #211                // Field java/lang/foreign/ValueLayout.ADDRESS:Ljava/lang/foreign/AddressLayout;
       864: ldc2_w        #255                // long 8l
       867: invokeinterface #257,  4          // InterfaceMethod java/lang/foreign/MemorySegment.get:(Ljava/lang/foreign/AddressLayout;J)Ljava/lang/foreign/MemorySegment;
       872: astore        17
       874: aload         15
       876: getstatic     #211                // Field java/lang/foreign/ValueLayout.ADDRESS:Ljava/lang/foreign/AddressLayout;
       879: ldc2_w        #264                // long 16l
       882: invokeinterface #257,  4          // InterfaceMethod java/lang/foreign/MemorySegment.get:(Ljava/lang/foreign/AddressLayout;J)Ljava/lang/foreign/MemorySegment;
       887: astore        18
       889: aload         16
       891: lconst_0
       892: invokeinterface #45,  3           // InterfaceMethod java/lang/foreign/MemorySegment.getString:(J)Ljava/lang/String;
       897: astore        19
       899: aload         19
       901: ldc_w         #296                // String x
       904: invokevirtual #277                // Method java/lang/String.equals:(Ljava/lang/Object;)Z
       907: ifeq          998
       910: getstatic     #140                // Field mh_get_x:Ljava/lang/invoke/MethodHandle;
       913: ifnonnull     998
       916: getstatic     #178                // Field LINKER:Ljava/lang/foreign/Linker;
       919: aload         17
       921: getstatic     #119                // Field java/lang/foreign/ValueLayout.JAVA_INT:Ljava/lang/foreign/ValueLayout$OfInt;
       924: iconst_1
       925: anewarray     #215                // class java/lang/foreign/MemoryLayout
       928: dup
       929: iconst_0
       930: getstatic     #211                // Field java/lang/foreign/ValueLayout.ADDRESS:Ljava/lang/foreign/AddressLayout;
       933: aastore
       934: invokestatic  #217                // InterfaceMethod java/lang/foreign/FunctionDescriptor.of:(Ljava/lang/foreign/MemoryLayout;[Ljava/lang/foreign/MemoryLayout;)Ljava/lang/foreign/FunctionDescriptor;
       937: iconst_0
       938: anewarray     #223                // class java/lang/foreign/Linker$Option
       941: invokeinterface #225,  4          // InterfaceMethod java/lang/foreign/Linker.downcallHandle:(Ljava/lang/foreign/MemorySegment;Ljava/lang/foreign/FunctionDescriptor;[Ljava/lang/foreign/Linker$Option;)Ljava/lang/invoke/MethodHandle;
       946: putstatic     #140                // Field mh_get_x:Ljava/lang/invoke/MethodHandle;
       949: aload         18
       951: getstatic     #244                // Field java/lang/foreign/MemorySegment.NULL:Ljava/lang/foreign/MemorySegment;
       954: invokeinterface #247,  2          // InterfaceMethod java/lang/foreign/MemorySegment.equals:(Ljava/lang/Object;)Z
       959: ifne          998
       962: getstatic     #178                // Field LINKER:Ljava/lang/foreign/Linker;
       965: aload         18
       967: iconst_2
       968: anewarray     #215                // class java/lang/foreign/MemoryLayout
       971: dup
       972: iconst_0
       973: getstatic     #211                // Field java/lang/foreign/ValueLayout.ADDRESS:Ljava/lang/foreign/AddressLayout;
       976: aastore
       977: dup
       978: iconst_1
       979: getstatic     #119                // Field java/lang/foreign/ValueLayout.JAVA_INT:Ljava/lang/foreign/ValueLayout$OfInt;
       982: aastore
       983: invokestatic  #231                // InterfaceMethod java/lang/foreign/FunctionDescriptor.ofVoid:([Ljava/lang/foreign/MemoryLayout;)Ljava/lang/foreign/FunctionDescriptor;
       986: iconst_0
       987: anewarray     #223                // class java/lang/foreign/Linker$Option
       990: invokeinterface #225,  4          // InterfaceMethod java/lang/foreign/Linker.downcallHandle:(Ljava/lang/foreign/MemorySegment;Ljava/lang/foreign/FunctionDescriptor;[Ljava/lang/foreign/Linker$Option;)Ljava/lang/invoke/MethodHandle;
       995: putstatic     #148                // Field mh_set_x:Ljava/lang/invoke/MethodHandle;
       998: aload         19
      1000: ldc_w         #298                // String y
      1003: invokevirtual #277                // Method java/lang/String.equals:(Ljava/lang/Object;)Z
      1006: ifeq          1097
      1009: getstatic     #161                // Field mh_get_y:Ljava/lang/invoke/MethodHandle;
      1012: ifnonnull     1097
      1015: getstatic     #178                // Field LINKER:Ljava/lang/foreign/Linker;
      1018: aload         17
      1020: getstatic     #119                // Field java/lang/foreign/ValueLayout.JAVA_INT:Ljava/lang/foreign/ValueLayout$OfInt;
      1023: iconst_1
      1024: anewarray     #215                // class java/lang/foreign/MemoryLayout
      1027: dup
      1028: iconst_0
      1029: getstatic     #211                // Field java/lang/foreign/ValueLayout.ADDRESS:Ljava/lang/foreign/AddressLayout;
      1032: aastore
      1033: invokestatic  #217                // InterfaceMethod java/lang/foreign/FunctionDescriptor.of:(Ljava/lang/foreign/MemoryLayout;[Ljava/lang/foreign/MemoryLayout;)Ljava/lang/foreign/FunctionDescriptor;
      1036: iconst_0
      1037: anewarray     #223                // class java/lang/foreign/Linker$Option
      1040: invokeinterface #225,  4          // InterfaceMethod java/lang/foreign/Linker.downcallHandle:(Ljava/lang/foreign/MemorySegment;Ljava/lang/foreign/FunctionDescriptor;[Ljava/lang/foreign/Linker$Option;)Ljava/lang/invoke/MethodHandle;
      1045: putstatic     #161                // Field mh_get_y:Ljava/lang/invoke/MethodHandle;
      1048: aload         18
      1050: getstatic     #244                // Field java/lang/foreign/MemorySegment.NULL:Ljava/lang/foreign/MemorySegment;
      1053: invokeinterface #247,  2          // InterfaceMethod java/lang/foreign/MemorySegment.equals:(Ljava/lang/Object;)Z
      1058: ifne          1097
      1061: getstatic     #178                // Field LINKER:Ljava/lang/foreign/Linker;
      1064: aload         18
      1066: iconst_2
      1067: anewarray     #215                // class java/lang/foreign/MemoryLayout
      1070: dup
      1071: iconst_0
      1072: getstatic     #211                // Field java/lang/foreign/ValueLayout.ADDRESS:Ljava/lang/foreign/AddressLayout;
      1075: aastore
      1076: dup
      1077: iconst_1
      1078: getstatic     #119                // Field java/lang/foreign/ValueLayout.JAVA_INT:Ljava/lang/foreign/ValueLayout$OfInt;
      1081: aastore
      1082: invokestatic  #231                // InterfaceMethod java/lang/foreign/FunctionDescriptor.ofVoid:([Ljava/lang/foreign/MemoryLayout;)Ljava/lang/foreign/FunctionDescriptor;
      1085: iconst_0
      1086: anewarray     #223                // class java/lang/foreign/Linker$Option
      1089: invokeinterface #225,  4          // InterfaceMethod java/lang/foreign/Linker.downcallHandle:(Ljava/lang/foreign/MemorySegment;Ljava/lang/foreign/FunctionDescriptor;[Ljava/lang/foreign/Linker$Option;)Ljava/lang/invoke/MethodHandle;
      1094: putstatic     #164                // Field mh_set_y:Ljava/lang/invoke/MethodHandle;
      1097: lload         13
      1099: lconst_1
      1100: ladd
      1101: lstore        13
      1103: goto          812
      1106: aload_3
      1107: getstatic     #211                // Field java/lang/foreign/ValueLayout.ADDRESS:Ljava/lang/foreign/AddressLayout;
      1110: ldc2_w        #300                // long 40l
      1113: invokeinterface #257,  4          // InterfaceMethod java/lang/foreign/MemorySegment.get:(Ljava/lang/foreign/AddressLayout;J)Ljava/lang/foreign/MemorySegment;
      1118: astore        13
      1120: getstatic     #178                // Field LINKER:Ljava/lang/foreign/Linker;
      1123: aload         13
      1125: iconst_1
      1126: anewarray     #215                // class java/lang/foreign/MemoryLayout
      1129: dup
      1130: iconst_0
      1131: getstatic     #211                // Field java/lang/foreign/ValueLayout.ADDRESS:Ljava/lang/foreign/AddressLayout;
      1134: aastore
      1135: invokestatic  #231                // InterfaceMethod java/lang/foreign/FunctionDescriptor.ofVoid:([Ljava/lang/foreign/MemoryLayout;)Ljava/lang/foreign/FunctionDescriptor;
      1138: iconst_0
      1139: anewarray     #223                // class java/lang/foreign/Linker$Option
      1142: invokeinterface #225,  4          // InterfaceMethod java/lang/foreign/Linker.downcallHandle:(Ljava/lang/foreign/MemorySegment;Ljava/lang/foreign/FunctionDescriptor;[Ljava/lang/foreign/Linker$Option;)Ljava/lang/invoke/MethodHandle;
      1147: putstatic     #167                // Field mh_dtor:Ljava/lang/invoke/MethodHandle;
      1150: aload_1
      1151: ifnull        1185
      1154: aload_1
      1155: invokeinterface #85,  1           // InterfaceMethod java/lang/foreign/Arena.close:()V
      1160: goto          1185
      1163: astore_2
      1164: aload_1
      1165: ifnull        1183
      1168: aload_1
      1169: invokeinterface #85,  1           // InterfaceMethod java/lang/foreign/Arena.close:()V
      1174: goto          1183
      1177: astore_3
      1178: aload_2
      1179: aload_3
      1180: invokevirtual #88                 // Method java/lang/Throwable.addSuppressed:(Ljava/lang/Throwable;)V
      1183: aload_2
      1184: athrow
      1185: goto          1201
      1188: astore_0
      1189: new           #54                 // class java/lang/RuntimeException
      1192: dup
      1193: ldc_w         #302                // String Failed to initialize bindings
      1196: aload_0
      1197: invokespecial #67                 // Method java/lang/RuntimeException."<init>":(Ljava/lang/String;Ljava/lang/Throwable;)V
      1200: athrow
      1201: return
      Exception table:
         from    to  target type
           145  1150  1163   Class java/lang/Throwable
          1168  1174  1177   Class java/lang/Throwable
            17  1185  1188   Class java/lang/Throwable
      LineNumberTable:
        line 17: 0
        line 20: 6
        line 21: 11
        line 41: 17
        line 42: 25
        line 43: 43
        line 41: 50
        line 45: 58
        line 46: 66
        line 47: 81
        line 45: 88
        line 49: 96
        line 50: 104
        line 51: 128
        line 49: 135
        line 53: 141
        line 54: 145
        line 55: 154
        line 56: 160
        line 58: 182
        line 60: 192
        line 61: 206
        line 62: 220
        line 63: 235
        line 64: 246
        line 65: 264
        line 66: 285
        line 67: 300
        line 68: 310
        line 69: 327
        line 71: 357
        line 72: 374
        line 74: 419
        line 75: 436
        line 77: 481
        line 78: 498
        line 80: 534
        line 81: 551
        line 63: 581
        line 85: 590
        line 86: 604
        line 87: 618
        line 88: 633
        line 89: 644
        line 90: 662
        line 91: 677
        line 92: 684
        line 94: 711
        line 95: 718
        line 88: 757
        line 99: 766
        line 100: 780
        line 101: 794
        line 102: 809
        line 103: 820
        line 104: 838
        line 105: 859
        line 106: 874
        line 107: 889
        line 108: 899
        line 109: 916
        line 110: 949
        line 111: 962
        line 114: 998
        line 115: 1015
        line 116: 1048
        line 117: 1061
        line 102: 1097
        line 122: 1106
        line 123: 1120
        line 124: 1150
        line 53: 1163
        line 127: 1185
        line 125: 1188
        line 126: 1189
        line 128: 1201
}
