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
        System.loadLibrary("JavaNativeLinkTest");
        LOOKUP = SymbolLookup.loaderLookup();
    }

    private static MethodHandle mh_init_0;
    private static MethodHandle mh_init_1;
    private static MethodHandle mh_print_0;
    private static MethodHandle mh_add_1;
    private static MethodHandle mh_dtor;

    static {
        try {
            MethodHandle getRegistryMH = LINKER.downcallHandle(
                LOOKUP.find("JNL_GetRegistry").orElseThrow(),
                FunctionDescriptor.of(ValueLayout.ADDRESS, ValueLayout.ADDRESS)
            );
            try (Arena tempArena = Arena.ofConfined()) {
                MemorySegment cName = tempArena.allocateFrom("Point");
                MemorySegment regPtr = (MemorySegment) getRegistryMH.invokeExact(cName);
                if (regPtr.equals(MemorySegment.NULL)) throw new RuntimeException("Registry not found for Point");

                MemorySegment methodsArray = regPtr.get(ValueLayout.ADDRESS, 8);
                long numMethods = regPtr.get(ValueLayout.JAVA_LONG, 16);
                for (long i = 0; i < numMethods; i++) {
                    MemorySegment methodPtr = methodsArray.asSlice(i * 16, 16);
                    MemorySegment namePtr = methodPtr.get(ValueLayout.ADDRESS, 0);
                    MemorySegment funcPtr = methodPtr.get(ValueLayout.ADDRESS, 8);
                    String name = namePtr.getString(0);
                    if (name.equals("print") && mh_print_0 == null) {
                        mh_print_0 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.ofVoid(ValueLayout.ADDRESS));
                    }
                    if (name.equals("add") && mh_add_1 == null) {
                        mh_add_1 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.of(ValueLayout.JAVA_INT, ValueLayout.ADDRESS, ValueLayout.JAVA_INT, ValueLayout.JAVA_INT));
                    }
                }

                MemorySegment constructorsArray = regPtr.get(ValueLayout.ADDRESS, 24);
                long numConstructors = regPtr.get(ValueLayout.JAVA_LONG, 32);
                for (long i = 0; i < numConstructors; i++) {
                    MemorySegment methodPtr = constructorsArray.asSlice(i * 16, 16);
                    MemorySegment funcPtr = methodPtr.get(ValueLayout.ADDRESS, 8);
                    if (i == 0) {
                        mh_init_0 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.of(ValueLayout.ADDRESS));
                    }
                    if (i == 1) {
                        mh_init_1 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.of(ValueLayout.ADDRESS, ValueLayout.JAVA_INT, ValueLayout.JAVA_INT));
                    }
                }

                MemorySegment destructorPtr = regPtr.get(ValueLayout.ADDRESS, 40);
                mh_dtor = LINKER.downcallHandle(destructorPtr, FunctionDescriptor.ofVoid(ValueLayout.ADDRESS));
            }
        } catch (Throwable e) {
            throw new RuntimeException("Failed to initialize bindings", e);
        }
    }

    public Point() {
        try {
            this.ptr = (MemorySegment) mh_init_0.invokeExact();
            this.arena = Arena.ofAuto();
        } catch (Throwable e) {
            throw new RuntimeException("Native constructor failed", e);
        }
    }

    public Point(int x, int y) {
        try {
            this.ptr = (MemorySegment) mh_init_1.invokeExact(x, y);
            this.arena = Arena.ofAuto();
        } catch (Throwable e) {
            throw new RuntimeException("Native constructor failed", e);
        }
    }

    public void print() {
        try {
            mh_print_0.invokeExact(this.ptr);
        } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
        }
    }

    public int add(int a, int b) {
        try {
            return (int) mh_add_1.invokeExact(this.ptr, a, b);
        } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
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
