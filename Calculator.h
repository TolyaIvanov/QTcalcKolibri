#ifndef CALCULATOR_H
#define CALCULATOR_H

#include <QString>
#include <QObject>


class Calculator: public QObject
{
    // ===========================================================
    // QT MACROS
    // ===========================================================

    Q_OBJECT

private:
    // ===========================================================
    // CONSTANTS
    // ===========================================================

    /** NONE **/
    static const unsigned char NONE_OPERATION_TYPE = 0;

    /** + **/
    static const unsigned char SUM_OPERATION_TYPE = 1;

    /** - **/
    static const unsigned char SUB_OPERATION_TYPE = 2;

    /** / **/
    static const unsigned char DIV_OPERATION_TYPE = 3;

    /** * **/
    static const unsigned char MUL_OPERATION_TYPE = 4;

    /** sqrt **/
    static const unsigned char SQRT_OPERATION_TYPE = 5;

    // ===========================================================
    // FIELDS
    // ===========================================================

    /** Stored Value. **/
    QString mStoredValue;

    /** Current argument. **/
    QString mCurrentSymbol;

    /** Current history of args **/
    QString mHistoryArg;

    /** Cached Output-String. **/
    QString mOutput;

    /** Current Brackey. **/
    QString mCurrentBrackey;

    /** Operation-Type **/
    unsigned char mOperationType;

    /** Operation-Type **/
    bool bShouldWeDropValues;


    // ===========================================================
    // METHODS
    // ===========================================================

    /**
      * Updates Output-string.
      *
      * @thread_safety - not thread-safe.
      * @throws - no exceptions.
    **/
    void onUpdateOutput( ) noexcept;

public:
    // -----------------------------------------------------------

    // ===========================================================
    // CONSTRUCTOR
    // ===========================================================

    /**
      * Calculator constructor.
      *
      * @param qParent - parent-QObject, default is null.
      * @throws - no exceptions.
    **/
    explicit Calculator( QObject *const qParent = nullptr ) noexcept : QObject ( qParent ),
        mStoredValue( "" ),
        mCurrentSymbol( "" ),
        mHistoryArg( " " ),
        mOutput( "" ),
        mCurrentBrackey("("),
        mOperationType( NONE_OPERATION_TYPE ),
        bShouldWeDropValues( false )
    {
    }

    // ===========================================================
    // DESTRUCTOR
    // ===========================================================

    /**
      * Calculator destructor.
      *
      * @throws - no exceptions.
    **/
    virtual ~Calculator( ) noexcept;

    // ===========================================================
    // GETTERS & SETTERS
    // ===========================================================

    /**
      * Called when operation (div, sub, sum, etc) called.
      *
      * @thread_safety - not thread-safe.
      * @param pType - operation-type in string-format ("+", "/", etc).
      * @returns - output-string to be displayed.
      * @throws - no exceptions.
    **/
    Q_INVOKABLE QString setOperationType( const QString pType ) noexcept;

    Q_INVOKABLE QString updateHistoryValue() noexcept;

    // ===========================================================
    // METHODS
    // ===========================================================

    /**
      * Called when brackey (separator) requested.
      *
      * @thread_safety - not thread-safe.
      * @returns - output-string to be displayed.
      * @throws - no exceptions.
    **/
    Q_INVOKABLE QString onBrackeys( ) noexcept;


    /**
      * Change operand before number.
      *
      * @thread_safety - not thread-safe.
      * @returns - output-string to be displayed.
      * @throws - no exceptions.
    **/
    Q_INVOKABLE QString onChangeOperand( ) noexcept;

    /**
      * Called when dot (separator) requested.
      *
      * @thread_safety - not thread-safe.
      * @returns - output-string to be displayed.
      * @throws - no exceptions.
    **/
    Q_INVOKABLE QString onDot( ) noexcept;

    /**
      * Called when QML Keyboard Inuput-Event handled.
      *
      * @thread_safety - not thread-safe.
      * @returns - output-string to be displayed.
      * @throws - no exceptions.
    **/
    Q_INVOKABLE QString onKeyboardInput( const QString pValue ) noexcept;

    /**
      * Called when number added to argument.
      *
      * @thread_safety - not thread-safe.
      * @param pNumber - number to add.
      * @returns - output-string to be displayed.
      * @throws - no exceptions.
    **/
    Q_INVOKABLE QString onNumberInput( const QString pNumber ) noexcept;


    /**
      * Calculates result using two arguments & operation-type.
      *
      * @thread_safety - not thread-safe.
      * @return - result in string-type.
      * @throws - no exceptions.
    **/
    Q_INVOKABLE QString doMath( ) noexcept;

    /**
      * Resets stored values.
      *
      * @thread_safety - not thread-safe.
      * @throws - no exceptions.
    **/
    Q_INVOKABLE void resetMemory( ) noexcept;

private:
    QString removeInvalidParentheses(QString str) noexcept;
    bool CheckValid(QString &str);

};

#endif // CALCULATOR_H
