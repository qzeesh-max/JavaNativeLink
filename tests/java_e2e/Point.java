import java.lang.foreign.*;
import java.lang.invoke.*;
import java.util.Optional;

public class Point implements AutoCloseable {
    private final MemorySegment ptr;
    private final Arena arena;

    public Point(MemorySegment ptr, Arena arena) {
        this.ptr = ptr;
        this.arena = arena;
    }

    public MemorySegment getPointer() { return ptr; }

    // --- Method Handles ---
    private static final Linker LINKER = Linker.nativeLinker();
    private static final SymbolLookup LOOKUP;
    static {
        System.loadLibrary("JavaNativeLink");
        System.loadLibrary("Point");
        LOOKUP = SymbolLookup.loaderLookup();
    }

    private static MethodHandle mh_init_0;
    private static MethodHandle mh_init_1;
    private static MethodHandle mh_print_0;
    private static MethodHandle mh_add_1;
    private static MethodHandle mh_greet_2;
    private static MethodHandle mh_multiplyUnsigned_3;
    private static MethodHandle mh_incReference_4;
    private static MethodHandle mh_crashMe_5;
    private static MethodHandle mh_applyCallback_6;
    private static MethodHandle mh_get_x;
    private static MethodHandle mh_set_x;
    private static MethodHandle mh_get_y;
    private static MethodHandle mh_set_y;
    private static MethodHandle mh_get_name;
    private static MethodHandle mh_set_name;
    private static MethodHandle mh_dtor;
    private static MethodHandle mh_getLastError;
    private static MethodHandle mh_clearLastError;
    private static MethodHandle mh_JNL_Free;

    static {
        try {
            mh_JNL_Free = LINKER.downcallHandle(
                LOOKUP.find("JNL_Free").orElseThrow(),
                FunctionDescriptor.ofVoid(ValueLayout.ADDRESS)
            );
            mh_getLastError = LINKER.downcallHandle(
                LOOKUP.find("JNL_GetLastError").orElseThrow(),
                FunctionDescriptor.of(ValueLayout.ADDRESS)
            );
            mh_clearLastError = LINKER.downcallHandle(
                LOOKUP.find("JNL_ClearLastError").orElseThrow(),
                FunctionDescriptor.ofVoid()
            );
            final MethodHandle getRegistryMH = LINKER.downcallHandle(
                LOOKUP.find("JNL_GetRegistry").orElseThrow(),
                FunctionDescriptor.of(ValueLayout.ADDRESS, ValueLayout.ADDRESS)
            );
            try (Arena tempArena = Arena.ofConfined()) {
                MemorySegment cName = tempArena.allocateFrom("Point");
                MemorySegment regPtr = (MemorySegment) getRegistryMH.invokeExact(cName);
                if (regPtr.equals(MemorySegment.NULL)) throw new RuntimeException("Registry not found for Point");
                regPtr = regPtr.reinterpret(64);

                MemorySegment methodsArray = regPtr.get(ValueLayout.ADDRESS, 8);
                long numMethods = regPtr.get(ValueLayout.JAVA_LONG, 16);
                methodsArray = methodsArray.reinterpret(numMethods * 16);
                for (long i = 0; i < numMethods; i++) {
                    MemorySegment methodPtr = methodsArray.asSlice(i * 16, 16);
                    MemorySegment namePtr = methodPtr.get(ValueLayout.ADDRESS, 0).reinterpret(1024);
                    MemorySegment funcPtr = methodPtr.get(ValueLayout.ADDRESS, 8);
                    String name = namePtr.getString(0);
                    if (name.equals("print") && mh_print_0 == null) {
                        mh_print_0 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.ofVoid(ValueLayout.ADDRESS));
                    }
                    if (name.equals("add") && mh_add_1 == null) {
                        mh_add_1 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.of(ValueLayout.JAVA_INT, ValueLayout.ADDRESS, ValueLayout.JAVA_INT, ValueLayout.JAVA_INT));
                    }
                    if (name.equals("greet") && mh_greet_2 == null) {
                        mh_greet_2 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.of(ValueLayout.ADDRESS, ValueLayout.ADDRESS, ValueLayout.ADDRESS));
                    }
                    if (name.equals("multiplyUnsigned") && mh_multiplyUnsigned_3 == null) {
                        mh_multiplyUnsigned_3 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.of(ValueLayout.JAVA_INT, ValueLayout.ADDRESS, ValueLayout.JAVA_INT, ValueLayout.JAVA_INT));
                    }
                    if (name.equals("incReference") && mh_incReference_4 == null) {
                        mh_incReference_4 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.ofVoid(ValueLayout.ADDRESS, ValueLayout.ADDRESS));
                    }
                    if (name.equals("crashMe") && mh_crashMe_5 == null) {
                        mh_crashMe_5 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.ofVoid(ValueLayout.ADDRESS));
                    }
                    if (name.equals("applyCallback") && mh_applyCallback_6 == null) {
                        mh_applyCallback_6 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.of(ValueLayout.JAVA_INT, ValueLayout.ADDRESS, ValueLayout.JAVA_INT, ValueLayout.ADDRESS));
                    }
                }

                MemorySegment constructorsArray = regPtr.get(ValueLayout.ADDRESS, 24);
                long numConstructors = regPtr.get(ValueLayout.JAVA_LONG, 32);
                constructorsArray = constructorsArray.reinterpret(numConstructors * 16);
                for (long i = 0; i < numConstructors; i++) {
                    MemorySegment methodPtr = constructorsArray.asSlice(i * 16, 16);
                    MemorySegment funcPtr = methodPtr.get(ValueLayout.ADDRESS, 8);
                    if (i == 0) {
                        mh_init_0 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.of(ValueLayout.ADDRESS));
                    }
                    if (i == 1) {
                        mh_init_1 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.of(ValueLayout.ADDRESS, ValueLayout.JAVA_INT, ValueLayout.JAVA_INT, ValueLayout.ADDRESS));
                    }
                }

                MemorySegment fieldsArray = regPtr.get(ValueLayout.ADDRESS, 48);
                long numFields = regPtr.get(ValueLayout.JAVA_LONG, 56);
                fieldsArray = fieldsArray.reinterpret(numFields * 24);
                for (long i = 0; i < numFields; i++) {
                    MemorySegment fieldPtr = fieldsArray.asSlice(i * 24, 24);
                    MemorySegment namePtr = fieldPtr.get(ValueLayout.ADDRESS, 0).reinterpret(1024);
                    MemorySegment getPtr = fieldPtr.get(ValueLayout.ADDRESS, 8);
                    MemorySegment setPtr = fieldPtr.get(ValueLayout.ADDRESS, 16);
                    String name = namePtr.getString(0);
                    if (name.equals("x") && mh_get_x == null) {
                        mh_get_x = LINKER.downcallHandle(getPtr, FunctionDescriptor.of(ValueLayout.JAVA_INT, ValueLayout.ADDRESS));
                        if (!setPtr.equals(MemorySegment.NULL)) {
                            mh_set_x = LINKER.downcallHandle(setPtr, FunctionDescriptor.ofVoid(ValueLayout.ADDRESS, ValueLayout.JAVA_INT));
                        }
                    }
                    if (name.equals("y") && mh_get_y == null) {
                        mh_get_y = LINKER.downcallHandle(getPtr, FunctionDescriptor.of(ValueLayout.JAVA_INT, ValueLayout.ADDRESS));
                        if (!setPtr.equals(MemorySegment.NULL)) {
                            mh_set_y = LINKER.downcallHandle(setPtr, FunctionDescriptor.ofVoid(ValueLayout.ADDRESS, ValueLayout.JAVA_INT));
                        }
                    }
                    if (name.equals("name") && mh_get_name == null) {
                        mh_get_name = LINKER.downcallHandle(getPtr, FunctionDescriptor.of(ValueLayout.ADDRESS, ValueLayout.ADDRESS));
                        if (!setPtr.equals(MemorySegment.NULL)) {
                            mh_set_name = LINKER.downcallHandle(setPtr, FunctionDescriptor.ofVoid(ValueLayout.ADDRESS, ValueLayout.ADDRESS));
                        }
                    }
                }

                MemorySegment destructorPtr = regPtr.get(ValueLayout.ADDRESS, 40);
                mh_dtor = LINKER.downcallHandle(destructorPtr, FunctionDescriptor.ofVoid(ValueLayout.ADDRESS));
            }
        } catch (Throwable e) {
            throw new RuntimeException("Failed to initialize bindings", e);
        }
    }

    private static void checkError() {
        try {
            MemorySegment err = (MemorySegment) mh_getLastError.invokeExact();
            err = err.reinterpret(1025);
            boolean hasError = err.get(ValueLayout.JAVA_BOOLEAN, 0);
            if (hasError) {
                String msg = err.getString(1);
                mh_clearLastError.invokeExact();
                throw new RuntimeException("C++ Exception: " + msg);
            }
        } catch (RuntimeException e) {
            throw e;
        } catch (Throwable e) {
            throw new RuntimeException("Error checking C++ exception state", e);
        }
    }

    public Point() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                this.ptr = (MemorySegment) mh_init_0.invokeExact();
                checkError();
                this.arena = Arena.ofAuto();
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native constructor failed", e);
        }
    }

    public Point(int x, int y, String name) {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                MemorySegment _seg_name = _tempArena.allocateFrom(name);
                this.ptr = (MemorySegment) mh_init_1.invokeExact((int)x, (int)y, _seg_name);
                checkError();
                this.arena = Arena.ofAuto();
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native constructor failed", e);
        }
    }

    public void print() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                mh_print_0.invokeExact((MemorySegment)this.ptr);
                checkError();
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
        }
    }

    public int add(int a, int b) {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                int _res = (int) mh_add_1.invokeExact((MemorySegment)this.ptr, (int)a, (int)b);
                checkError();
                return (int)_res;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
        }
    }

    public String greet(Point other) {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                MemorySegment _res = (MemorySegment) mh_greet_2.invokeExact((MemorySegment)this.ptr, other.getPointer());
                checkError();
                String _retStr = _res.reinterpret(Long.MAX_VALUE).getString(0);
                mh_JNL_Free.invokeExact(_res);
                return _retStr;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
        }
    }

    public long multiplyUnsigned(long a, long b) {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                int _res = (int) mh_multiplyUnsigned_3.invokeExact((MemorySegment)this.ptr, (int)a, (int)b);
                checkError();
                return (long)_res & 0xFFFFFFFFL;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
        }
    }

    public void incReference(int[] val) {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                MemorySegment _seg_val = _tempArena.allocateFrom(ValueLayout.JAVA_INT, val);
                mh_incReference_4.invokeExact((MemorySegment)this.ptr, _seg_val);
                checkError();
                MemorySegment.copy(_seg_val, ValueLayout.JAVA_INT, 0, val, 0, val.length);
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
        }
    }

    public void crashMe() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                mh_crashMe_5.invokeExact((MemorySegment)this.ptr);
                checkError();
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
        }
    }

    public int applyCallback(int a, MemorySegment cb) {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                int _res = (int) mh_applyCallback_6.invokeExact((MemorySegment)this.ptr, (int)a, cb);
                checkError();
                return (int)_res;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
        }
    }

    public int get_x() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                int _res = (int) mh_get_x.invokeExact((MemorySegment)this.ptr);
                checkError();
                return (int)_res;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native field get failed", e);
        }
    }

    public void set_x(int val) {
        try {
            if (mh_set_x == null) throw new UnsupportedOperationException("Field is const");
            try (Arena _tempArena = Arena.ofConfined()) {
                mh_set_x.invokeExact((MemorySegment)this.ptr, (int)val);
                checkError();
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native field set failed", e);
        }
    }

    public int get_y() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                int _res = (int) mh_get_y.invokeExact((MemorySegment)this.ptr);
                checkError();
                return (int)_res;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native field get failed", e);
        }
    }

    public void set_y(int val) {
        try {
            if (mh_set_y == null) throw new UnsupportedOperationException("Field is const");
            try (Arena _tempArena = Arena.ofConfined()) {
                mh_set_y.invokeExact((MemorySegment)this.ptr, (int)val);
                checkError();
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native field set failed", e);
        }
    }

    public String get_name() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                MemorySegment _res = (MemorySegment) mh_get_name.invokeExact((MemorySegment)this.ptr);
                checkError();
                String _retStr = _res.reinterpret(Long.MAX_VALUE).getString(0);
                mh_JNL_Free.invokeExact(_res);
                return _retStr;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native field get failed", e);
        }
    }

    public void set_name(String val) {
        try {
            if (mh_set_name == null) throw new UnsupportedOperationException("Field is const");
            try (Arena _tempArena = Arena.ofConfined()) {
                MemorySegment _seg_val = _tempArena.allocateFrom(val);
                mh_set_name.invokeExact((MemorySegment)this.ptr, _seg_val);
                checkError();
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native field set failed", e);
        }
    }

    @Override
    public void close() {
        try {
            mh_dtor.invokeExact(this.ptr);
        } catch (Throwable e) {
            throw new RuntimeException("Destructor failed", e);
        }
    }
}
