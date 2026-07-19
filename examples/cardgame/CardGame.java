import java.lang.foreign.*;
import java.lang.invoke.*;
import java.util.Optional;

public class CardGame implements AutoCloseable {
    private final MemorySegment ptr;
    private final Arena arena;

    public CardGame(MemorySegment ptr, Arena arena) {
        this.ptr = ptr;
        this.arena = arena;
    }

    public MemorySegment getPointer() { return ptr; }

    // --- Method Handles ---
    private static final Linker LINKER = Linker.nativeLinker();
    private static final SymbolLookup LOOKUP;
    static {
        System.loadLibrary("JavaNativeLink");
        System.loadLibrary("CardGame");
        LOOKUP = SymbolLookup.loaderLookup();
    }

    private static MethodHandle mh_init_0;
    private static MethodHandle mh_startNewGame_0;
    private static MethodHandle mh_playerHit_1;
    private static MethodHandle mh_playerStand_2;
    private static MethodHandle mh_getPlayerScore_3;
    private static MethodHandle mh_getDealerScore_4;
    private static MethodHandle mh_getPlayerWins_5;
    private static MethodHandle mh_getDealerWins_6;
    private static MethodHandle mh_getPushes_7;
    private static MethodHandle mh_getPlayerCards_8;
    private static MethodHandle mh_getDealerCards_9;
    private static MethodHandle mh_getGameStatus_10;
    private static MethodHandle mh_getPlayerCardCount_11;
    private static MethodHandle mh_getDealerCardCount_12;
    private static MethodHandle mh_isGameOver_13;
    private static MethodHandle mh_initDeck_14;
    private static MethodHandle mh_shuffleDeck_15;
    private static MethodHandle mh_drawCard_16;
    private static MethodHandle mh_cardValue_17;
    private static MethodHandle mh_calculateScore_18;
    private static MethodHandle mh_joinCards_19;
    private static MethodHandle mh_get_status;
    private static MethodHandle mh_set_status;
    private static MethodHandle mh_get_playerScore;
    private static MethodHandle mh_set_playerScore;
    private static MethodHandle mh_get_dealerScore;
    private static MethodHandle mh_set_dealerScore;
    private static MethodHandle mh_get_playerWins;
    private static MethodHandle mh_set_playerWins;
    private static MethodHandle mh_get_dealerWins;
    private static MethodHandle mh_set_dealerWins;
    private static MethodHandle mh_get_pushes;
    private static MethodHandle mh_set_pushes;
    private static MethodHandle mh_get_deck;
    private static MethodHandle mh_set_deck;
    private static MethodHandle mh_get_playerHand;
    private static MethodHandle mh_set_playerHand;
    private static MethodHandle mh_get_dealerHand;
    private static MethodHandle mh_set_dealerHand;
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
                MemorySegment cName = tempArena.allocateFrom("CardGame");
                MemorySegment regPtr = (MemorySegment) getRegistryMH.invokeExact(cName);
                if (regPtr.equals(MemorySegment.NULL)) throw new RuntimeException("Registry not found for CardGame");
                regPtr = regPtr.reinterpret(64);

                MemorySegment methodsArray = regPtr.get(ValueLayout.ADDRESS, 8);
                long numMethods = regPtr.get(ValueLayout.JAVA_LONG, 16);
                methodsArray = methodsArray.reinterpret(numMethods * 16);
                for (long i = 0; i < numMethods; i++) {
                    MemorySegment methodPtr = methodsArray.asSlice(i * 16, 16);
                    MemorySegment namePtr = methodPtr.get(ValueLayout.ADDRESS, 0).reinterpret(1024);
                    MemorySegment funcPtr = methodPtr.get(ValueLayout.ADDRESS, 8);
                    String name = namePtr.getString(0);
                    if (name.equals("startNewGame") && mh_startNewGame_0 == null) {
                        mh_startNewGame_0 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.ofVoid(ValueLayout.ADDRESS));
                    }
                    if (name.equals("playerHit") && mh_playerHit_1 == null) {
                        mh_playerHit_1 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.ofVoid(ValueLayout.ADDRESS));
                    }
                    if (name.equals("playerStand") && mh_playerStand_2 == null) {
                        mh_playerStand_2 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.ofVoid(ValueLayout.ADDRESS));
                    }
                    if (name.equals("getPlayerScore") && mh_getPlayerScore_3 == null) {
                        mh_getPlayerScore_3 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.of(ValueLayout.JAVA_INT, ValueLayout.ADDRESS));
                    }
                    if (name.equals("getDealerScore") && mh_getDealerScore_4 == null) {
                        mh_getDealerScore_4 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.of(ValueLayout.JAVA_INT, ValueLayout.ADDRESS));
                    }
                    if (name.equals("getPlayerWins") && mh_getPlayerWins_5 == null) {
                        mh_getPlayerWins_5 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.of(ValueLayout.JAVA_INT, ValueLayout.ADDRESS));
                    }
                    if (name.equals("getDealerWins") && mh_getDealerWins_6 == null) {
                        mh_getDealerWins_6 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.of(ValueLayout.JAVA_INT, ValueLayout.ADDRESS));
                    }
                    if (name.equals("getPushes") && mh_getPushes_7 == null) {
                        mh_getPushes_7 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.of(ValueLayout.JAVA_INT, ValueLayout.ADDRESS));
                    }
                    if (name.equals("getPlayerCards") && mh_getPlayerCards_8 == null) {
                        mh_getPlayerCards_8 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.of(ValueLayout.ADDRESS, ValueLayout.ADDRESS));
                    }
                    if (name.equals("getDealerCards") && mh_getDealerCards_9 == null) {
                        mh_getDealerCards_9 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.of(ValueLayout.ADDRESS, ValueLayout.ADDRESS));
                    }
                    if (name.equals("getGameStatus") && mh_getGameStatus_10 == null) {
                        mh_getGameStatus_10 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.of(ValueLayout.ADDRESS, ValueLayout.ADDRESS));
                    }
                    if (name.equals("getPlayerCardCount") && mh_getPlayerCardCount_11 == null) {
                        mh_getPlayerCardCount_11 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.of(ValueLayout.JAVA_INT, ValueLayout.ADDRESS));
                    }
                    if (name.equals("getDealerCardCount") && mh_getDealerCardCount_12 == null) {
                        mh_getDealerCardCount_12 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.of(ValueLayout.JAVA_INT, ValueLayout.ADDRESS));
                    }
                    if (name.equals("isGameOver") && mh_isGameOver_13 == null) {
                        mh_isGameOver_13 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.of(ValueLayout.JAVA_INT, ValueLayout.ADDRESS));
                    }
                    if (name.equals("initDeck") && mh_initDeck_14 == null) {
                        mh_initDeck_14 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.ofVoid(ValueLayout.ADDRESS));
                    }
                    if (name.equals("shuffleDeck") && mh_shuffleDeck_15 == null) {
                        mh_shuffleDeck_15 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.ofVoid(ValueLayout.ADDRESS));
                    }
                    if (name.equals("drawCard") && mh_drawCard_16 == null) {
                        mh_drawCard_16 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.of(ValueLayout.ADDRESS, ValueLayout.ADDRESS));
                    }
                    if (name.equals("cardValue") && mh_cardValue_17 == null) {
                        mh_cardValue_17 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.of(ValueLayout.JAVA_INT, ValueLayout.ADDRESS, ValueLayout.ADDRESS));
                    }
                    if (name.equals("calculateScore") && mh_calculateScore_18 == null) {
                        mh_calculateScore_18 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.of(ValueLayout.JAVA_INT, ValueLayout.ADDRESS, ValueLayout.ADDRESS));
                    }
                    if (name.equals("joinCards") && mh_joinCards_19 == null) {
                        mh_joinCards_19 = LINKER.downcallHandle(funcPtr, FunctionDescriptor.of(ValueLayout.ADDRESS, ValueLayout.ADDRESS, ValueLayout.ADDRESS));
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
                    if (name.equals("status") && mh_get_status == null) {
                        mh_get_status = LINKER.downcallHandle(getPtr, FunctionDescriptor.of(ValueLayout.ADDRESS, ValueLayout.ADDRESS));
                        if (!setPtr.equals(MemorySegment.NULL)) {
                            mh_set_status = LINKER.downcallHandle(setPtr, FunctionDescriptor.ofVoid(ValueLayout.ADDRESS, ValueLayout.ADDRESS));
                        }
                    }
                    if (name.equals("playerScore") && mh_get_playerScore == null) {
                        mh_get_playerScore = LINKER.downcallHandle(getPtr, FunctionDescriptor.of(ValueLayout.JAVA_INT, ValueLayout.ADDRESS));
                        if (!setPtr.equals(MemorySegment.NULL)) {
                            mh_set_playerScore = LINKER.downcallHandle(setPtr, FunctionDescriptor.ofVoid(ValueLayout.ADDRESS, ValueLayout.JAVA_INT));
                        }
                    }
                    if (name.equals("dealerScore") && mh_get_dealerScore == null) {
                        mh_get_dealerScore = LINKER.downcallHandle(getPtr, FunctionDescriptor.of(ValueLayout.JAVA_INT, ValueLayout.ADDRESS));
                        if (!setPtr.equals(MemorySegment.NULL)) {
                            mh_set_dealerScore = LINKER.downcallHandle(setPtr, FunctionDescriptor.ofVoid(ValueLayout.ADDRESS, ValueLayout.JAVA_INT));
                        }
                    }
                    if (name.equals("playerWins") && mh_get_playerWins == null) {
                        mh_get_playerWins = LINKER.downcallHandle(getPtr, FunctionDescriptor.of(ValueLayout.JAVA_INT, ValueLayout.ADDRESS));
                        if (!setPtr.equals(MemorySegment.NULL)) {
                            mh_set_playerWins = LINKER.downcallHandle(setPtr, FunctionDescriptor.ofVoid(ValueLayout.ADDRESS, ValueLayout.JAVA_INT));
                        }
                    }
                    if (name.equals("dealerWins") && mh_get_dealerWins == null) {
                        mh_get_dealerWins = LINKER.downcallHandle(getPtr, FunctionDescriptor.of(ValueLayout.JAVA_INT, ValueLayout.ADDRESS));
                        if (!setPtr.equals(MemorySegment.NULL)) {
                            mh_set_dealerWins = LINKER.downcallHandle(setPtr, FunctionDescriptor.ofVoid(ValueLayout.ADDRESS, ValueLayout.JAVA_INT));
                        }
                    }
                    if (name.equals("pushes") && mh_get_pushes == null) {
                        mh_get_pushes = LINKER.downcallHandle(getPtr, FunctionDescriptor.of(ValueLayout.JAVA_INT, ValueLayout.ADDRESS));
                        if (!setPtr.equals(MemorySegment.NULL)) {
                            mh_set_pushes = LINKER.downcallHandle(setPtr, FunctionDescriptor.ofVoid(ValueLayout.ADDRESS, ValueLayout.JAVA_INT));
                        }
                    }
                    if (name.equals("deck") && mh_get_deck == null) {
                        mh_get_deck = LINKER.downcallHandle(getPtr, FunctionDescriptor.of(ValueLayout.ADDRESS, ValueLayout.ADDRESS));
                        if (!setPtr.equals(MemorySegment.NULL)) {
                            mh_set_deck = LINKER.downcallHandle(setPtr, FunctionDescriptor.ofVoid(ValueLayout.ADDRESS, ValueLayout.ADDRESS));
                        }
                    }
                    if (name.equals("playerHand") && mh_get_playerHand == null) {
                        mh_get_playerHand = LINKER.downcallHandle(getPtr, FunctionDescriptor.of(ValueLayout.ADDRESS, ValueLayout.ADDRESS));
                        if (!setPtr.equals(MemorySegment.NULL)) {
                            mh_set_playerHand = LINKER.downcallHandle(setPtr, FunctionDescriptor.ofVoid(ValueLayout.ADDRESS, ValueLayout.ADDRESS));
                        }
                    }
                    if (name.equals("dealerHand") && mh_get_dealerHand == null) {
                        mh_get_dealerHand = LINKER.downcallHandle(getPtr, FunctionDescriptor.of(ValueLayout.ADDRESS, ValueLayout.ADDRESS));
                        if (!setPtr.equals(MemorySegment.NULL)) {
                            mh_set_dealerHand = LINKER.downcallHandle(setPtr, FunctionDescriptor.ofVoid(ValueLayout.ADDRESS, ValueLayout.ADDRESS));
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

    public CardGame() {
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

    public void startNewGame() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                mh_startNewGame_0.invokeExact((MemorySegment)this.ptr);
                checkError();
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
        }
    }

    public void playerHit() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                mh_playerHit_1.invokeExact((MemorySegment)this.ptr);
                checkError();
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
        }
    }

    public void playerStand() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                mh_playerStand_2.invokeExact((MemorySegment)this.ptr);
                checkError();
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
        }
    }

    public int getPlayerScore() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                int _res = (int) mh_getPlayerScore_3.invokeExact((MemorySegment)this.ptr);
                checkError();
                return (int)_res;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
        }
    }

    public int getDealerScore() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                int _res = (int) mh_getDealerScore_4.invokeExact((MemorySegment)this.ptr);
                checkError();
                return (int)_res;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
        }
    }

    public int getPlayerWins() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                int _res = (int) mh_getPlayerWins_5.invokeExact((MemorySegment)this.ptr);
                checkError();
                return (int)_res;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
        }
    }

    public int getDealerWins() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                int _res = (int) mh_getDealerWins_6.invokeExact((MemorySegment)this.ptr);
                checkError();
                return (int)_res;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
        }
    }

    public int getPushes() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                int _res = (int) mh_getPushes_7.invokeExact((MemorySegment)this.ptr);
                checkError();
                return (int)_res;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
        }
    }

    public String getPlayerCards() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                MemorySegment _res = (MemorySegment) mh_getPlayerCards_8.invokeExact((MemorySegment)this.ptr);
                checkError();
                String _retStr = _res.reinterpret(Long.MAX_VALUE).getString(0);
                mh_JNL_Free.invokeExact(_res);
                return _retStr;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
        }
    }

    public String getDealerCards() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                MemorySegment _res = (MemorySegment) mh_getDealerCards_9.invokeExact((MemorySegment)this.ptr);
                checkError();
                String _retStr = _res.reinterpret(Long.MAX_VALUE).getString(0);
                mh_JNL_Free.invokeExact(_res);
                return _retStr;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
        }
    }

    public String getGameStatus() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                MemorySegment _res = (MemorySegment) mh_getGameStatus_10.invokeExact((MemorySegment)this.ptr);
                checkError();
                String _retStr = _res.reinterpret(Long.MAX_VALUE).getString(0);
                mh_JNL_Free.invokeExact(_res);
                return _retStr;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
        }
    }

    public int getPlayerCardCount() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                int _res = (int) mh_getPlayerCardCount_11.invokeExact((MemorySegment)this.ptr);
                checkError();
                return (int)_res;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
        }
    }

    public int getDealerCardCount() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                int _res = (int) mh_getDealerCardCount_12.invokeExact((MemorySegment)this.ptr);
                checkError();
                return (int)_res;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
        }
    }

    public int isGameOver() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                int _res = (int) mh_isGameOver_13.invokeExact((MemorySegment)this.ptr);
                checkError();
                return (int)_res;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
        }
    }

    public void initDeck() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                mh_initDeck_14.invokeExact((MemorySegment)this.ptr);
                checkError();
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
        }
    }

    public void shuffleDeck() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                mh_shuffleDeck_15.invokeExact((MemorySegment)this.ptr);
                checkError();
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
        }
    }

    public String drawCard() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                MemorySegment _res = (MemorySegment) mh_drawCard_16.invokeExact((MemorySegment)this.ptr);
                checkError();
                String _retStr = _res.reinterpret(Long.MAX_VALUE).getString(0);
                mh_JNL_Free.invokeExact(_res);
                return _retStr;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
        }
    }

    public int cardValue(MemorySegment card) {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                int _res = (int) mh_cardValue_17.invokeExact((MemorySegment)this.ptr, card);
                checkError();
                return (int)_res;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
        }
    }

    public int calculateScore(MemorySegment hand) {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                int _res = (int) mh_calculateScore_18.invokeExact((MemorySegment)this.ptr, hand);
                checkError();
                return (int)_res;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
        }
    }

    public String joinCards(MemorySegment hand) {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                MemorySegment _res = (MemorySegment) mh_joinCards_19.invokeExact((MemorySegment)this.ptr, hand);
                checkError();
                String _retStr = _res.reinterpret(Long.MAX_VALUE).getString(0);
                mh_JNL_Free.invokeExact(_res);
                return _retStr;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native call failed", e);
        }
    }

    public String get_status() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                MemorySegment _res = (MemorySegment) mh_get_status.invokeExact((MemorySegment)this.ptr);
                checkError();
                String _retStr = _res.reinterpret(Long.MAX_VALUE).getString(0);
                mh_JNL_Free.invokeExact(_res);
                return _retStr;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native field get failed", e);
        }
    }

    public void set_status(String val) {
        try {
            if (mh_set_status == null) throw new UnsupportedOperationException("Field is const");
            try (Arena _tempArena = Arena.ofConfined()) {
                MemorySegment _seg_val = _tempArena.allocateFrom(val);
                mh_set_status.invokeExact((MemorySegment)this.ptr, _seg_val);
                checkError();
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native field set failed", e);
        }
    }

    public int get_playerScore() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                int _res = (int) mh_get_playerScore.invokeExact((MemorySegment)this.ptr);
                checkError();
                return (int)_res;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native field get failed", e);
        }
    }

    public void set_playerScore(int val) {
        try {
            if (mh_set_playerScore == null) throw new UnsupportedOperationException("Field is const");
            try (Arena _tempArena = Arena.ofConfined()) {
                mh_set_playerScore.invokeExact((MemorySegment)this.ptr, (int)val);
                checkError();
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native field set failed", e);
        }
    }

    public int get_dealerScore() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                int _res = (int) mh_get_dealerScore.invokeExact((MemorySegment)this.ptr);
                checkError();
                return (int)_res;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native field get failed", e);
        }
    }

    public void set_dealerScore(int val) {
        try {
            if (mh_set_dealerScore == null) throw new UnsupportedOperationException("Field is const");
            try (Arena _tempArena = Arena.ofConfined()) {
                mh_set_dealerScore.invokeExact((MemorySegment)this.ptr, (int)val);
                checkError();
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native field set failed", e);
        }
    }

    public int get_playerWins() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                int _res = (int) mh_get_playerWins.invokeExact((MemorySegment)this.ptr);
                checkError();
                return (int)_res;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native field get failed", e);
        }
    }

    public void set_playerWins(int val) {
        try {
            if (mh_set_playerWins == null) throw new UnsupportedOperationException("Field is const");
            try (Arena _tempArena = Arena.ofConfined()) {
                mh_set_playerWins.invokeExact((MemorySegment)this.ptr, (int)val);
                checkError();
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native field set failed", e);
        }
    }

    public int get_dealerWins() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                int _res = (int) mh_get_dealerWins.invokeExact((MemorySegment)this.ptr);
                checkError();
                return (int)_res;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native field get failed", e);
        }
    }

    public void set_dealerWins(int val) {
        try {
            if (mh_set_dealerWins == null) throw new UnsupportedOperationException("Field is const");
            try (Arena _tempArena = Arena.ofConfined()) {
                mh_set_dealerWins.invokeExact((MemorySegment)this.ptr, (int)val);
                checkError();
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native field set failed", e);
        }
    }

    public int get_pushes() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                int _res = (int) mh_get_pushes.invokeExact((MemorySegment)this.ptr);
                checkError();
                return (int)_res;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native field get failed", e);
        }
    }

    public void set_pushes(int val) {
        try {
            if (mh_set_pushes == null) throw new UnsupportedOperationException("Field is const");
            try (Arena _tempArena = Arena.ofConfined()) {
                mh_set_pushes.invokeExact((MemorySegment)this.ptr, (int)val);
                checkError();
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native field set failed", e);
        }
    }

    public MemorySegment get_deck() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                MemorySegment _res = (MemorySegment) mh_get_deck.invokeExact((MemorySegment)this.ptr);
                checkError();
                return _res;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native field get failed", e);
        }
    }

    public void set_deck(MemorySegment val) {
        try {
            if (mh_set_deck == null) throw new UnsupportedOperationException("Field is const");
            try (Arena _tempArena = Arena.ofConfined()) {
                mh_set_deck.invokeExact((MemorySegment)this.ptr, val);
                checkError();
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native field set failed", e);
        }
    }

    public MemorySegment get_playerHand() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                MemorySegment _res = (MemorySegment) mh_get_playerHand.invokeExact((MemorySegment)this.ptr);
                checkError();
                return _res;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native field get failed", e);
        }
    }

    public void set_playerHand(MemorySegment val) {
        try {
            if (mh_set_playerHand == null) throw new UnsupportedOperationException("Field is const");
            try (Arena _tempArena = Arena.ofConfined()) {
                mh_set_playerHand.invokeExact((MemorySegment)this.ptr, val);
                checkError();
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native field set failed", e);
        }
    }

    public MemorySegment get_dealerHand() {
        try {
            try (Arena _tempArena = Arena.ofConfined()) {
                MemorySegment _res = (MemorySegment) mh_get_dealerHand.invokeExact((MemorySegment)this.ptr);
                checkError();
                return _res;
            }
        } catch (RuntimeException e) { throw e; } catch (Throwable e) {
            throw new RuntimeException("Native field get failed", e);
        }
    }

    public void set_dealerHand(MemorySegment val) {
        try {
            if (mh_set_dealerHand == null) throw new UnsupportedOperationException("Field is const");
            try (Arena _tempArena = Arena.ofConfined()) {
                mh_set_dealerHand.invokeExact((MemorySegment)this.ptr, val);
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
