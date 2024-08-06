//C++ Mathematical Expression Toolkit Library
#include "tinyexpr.h"

#include "Calculator.h"

#include "qdebug.h"

#include <QtMath>

#include <QQueue>

#include <QStack>

#include <QTextStream>


// ===========================================================
// CONSTRUCTOR
// ===========================================================

// ===========================================================
// DESTRUCTOR
// ===========================================================

Calculator::~Calculator() noexcept =
    default;

// ===========================================================
// GETTERS & SETTERS
// ===========================================================

/*
 *
 *      if (mCurrentSymbol == "+" || mCurrentSymbol == "-" || mCurrentSymbol == "/" || mCurrentSymbol == "%" || mCurrentSymbol == "*")
        {
            // Update Output
            onUpdateOutput( );

            // Return output
            return( mOutput );
        }
 *
 */
QString Calculator::setOperationType(const QString pType) noexcept {
#ifdef QT_DEBUG // DEBUG
    qDebug("CalculatorLogic::setOperationType");
#endif // DEBUG
    if (bShouldWeDropValues) {
        mHistoryArg = "";

        bShouldWeDropValues = false;
    }

    mHistoryArg = mHistoryArg + mCurrentSymbol + pType;
    mCurrentSymbol = "";

    // Update Output
    onUpdateOutput();

    // Return output
    return (mOutput);
}

QString Calculator::updateHistoryValue() noexcept {
    return mHistoryArg;
}

// ===========================================================
// METHODS
// ===========================================================

QString Calculator::onNumberInput(const QString pVal) noexcept {

#ifdef QT_DEBUG // DEBUG
    qDebug() << "Calculator::onNumberInput =" << pVal;
#endif // DEBUG
    if (bShouldWeDropValues) {
        resetMemory();

        bShouldWeDropValues = false;
    }

    mCurrentSymbol += pVal;

    //mHistoryArg += pVal;

    // Update output
    onUpdateOutput();

    // Return Output
    return (mOutput);
}

void Calculator::onUpdateOutput() noexcept {
#ifdef QT_DEBUG // DEBUG
    qDebug("Calculator::onUpdateOutput");

#endif // DEBUG
    // Reset Output-string.

    mOutput = "";

    // Operation-Type
    if (mOperationType != NONE_OPERATION_TYPE) {
        // Append operation-symbol.
        switch (mOperationType) {
        case DIV_OPERATION_TYPE: {
            mHistoryArg += " / ";
            break;
        }
        case MUL_OPERATION_TYPE: {
            mHistoryArg += " * ";
            break;
        }
        case SQRT_OPERATION_TYPE: {
            break;
        }
        case SUB_OPERATION_TYPE: {
            mHistoryArg += " - ";
            break;
        }
        default:
        case SUM_OPERATION_TYPE: {
            mHistoryArg += " + ";
            break;
        }
        }
    }

    if (mCurrentSymbol.size() > 0)
        mOutput = mCurrentSymbol;

    // 0
    if (mOutput.size() < 1)
        mOutput = "0";

}

Q_INVOKABLE QString Calculator::onBrackeys() noexcept {
    bShouldWeDropValues = false;

    if (mCurrentBrackey == "(") {
        mCurrentSymbol.insert(0, mCurrentBrackey);
        mCurrentBrackey = ")";
    } else {
        mCurrentSymbol.append(mCurrentBrackey);
        mCurrentBrackey = "(";
    }

    return mCurrentSymbol;
}

Q_INVOKABLE QString Calculator::onChangeOperand() noexcept {
    bShouldWeDropValues = false;

    if (mCurrentSymbol.length() > 0 && mCurrentSymbol.at(0).isDigit()) {
        mCurrentSymbol = "-" + mCurrentSymbol;

        return mCurrentSymbol;
    }

    if (mCurrentSymbol.length() > 0 && mCurrentSymbol.at(0) == '-') {
        mCurrentSymbol.remove(0, 1);

        return mCurrentSymbol;
    }

    return "0";
}

Q_INVOKABLE QString Calculator::onDot() noexcept {
    // 0
    if (mCurrentSymbol.size() < 1) {

        // Set mCurrentSymbol
        mCurrentSymbol = "0.";

        // Update Output
        onUpdateOutput();

        // Return Output
        return (mOutput);

    } /// 0

    // Cancel, if Right Argument already contains symbol.
    if (mCurrentSymbol.contains('.'))
        return (mOutput);

    if (mCurrentSymbol[mCurrentSymbol.length() - 1] == ')')
        return (mOutput);

    // Append dot-symbol to Right-Argument.
    mCurrentSymbol += ".";

    // Update Output
    onUpdateOutput();

    // Return Output
    return (mOutput);

}

QString Calculator::onKeyboardInput(const QString pValue) noexcept {

#ifdef QT_DEBUG // DEBUG
    qDebug("Calculator::onKeyboardInput");
#endif // DEBUG

    // Filter Number Input
    if (pValue == "0" || pValue == "1" || pValue == "2" ||
        pValue == "3" || pValue == "4" || pValue == "5" ||
        pValue == "6" || pValue == "7" || pValue == "8" ||
        pValue == "9")
        return (onNumberInput(pValue));

    // Return Output
    return (mOutput);

}

QString Calculator::doMath() noexcept {
    mHistoryArg = mHistoryArg.remove("nan");
    mHistoryArg = mHistoryArg.remove(' ') + mCurrentSymbol;
    mHistoryArg = removeInvalidParentheses(mHistoryArg);

    te_parser tep;

    std::string s = mHistoryArg.toStdString();
    const double answer = tep.evaluate(s);
    mCurrentSymbol = QString::number(answer);
    qDebug() << "doMath of" << mHistoryArg << "=" << answer;

    bShouldWeDropValues = true;

    // Reset Operation-Type.
    mOperationType = NONE_OPERATION_TYPE;

    onUpdateOutput();

    return (mOutput);
}

QString Calculator::removeInvalidParentheses(QString str) noexcept {
    QQueue < QString > queue;
    queue.enqueue(str);
    QVector < QString > um;
    QHash < QString, int > visited;
    bool bk = false;
    if (CheckValid(str)) {
        um.push_back(str);
        return um[0];
    }
    while (!queue.empty()) {
        int sz = queue.size();
        while (sz--) {
            QString tmp = queue.front();
            queue.dequeue();
            for (int i = 0; i < tmp.size(); i++) {
                if (str[i] >= 'a' && str[i] <= 'z') continue;
                QString z = tmp;
                z.remove(i, 1);
                if (visited.count(z)) continue;
                if (CheckValid(z)) {
                    um.push_back(z);
                    bk = true;
                }
                visited[z]++;
                queue.enqueue(z);
            }
        }
        if (bk) break;
    }
    return um[0];
}

bool Calculator::CheckValid(QString & str) {
    QStack < QChar > st;
    int i = 0, n = str.size();
    while (i < n) {
        if (str[i] == '(') {
            QChar strToPush = str[i];
            st.push(strToPush);
        } else if (str[i] == ')') {
            if (st.empty())
                return false;
            st.pop();
        }
        i++;
    }
    if (st.empty())
        return true;
    return false;
}

void Calculator::resetMemory() noexcept {

#ifdef QT_DEBUG // DEBUG
    qDebug("Calculator::resetMemory");
#endif // DEBUG

    // Reset Stored Value
    mCurrentSymbol = "";
    mStoredValue.clear();
    mHistoryArg.clear();
    mHistoryArg = "";
    mOutput = "0";
    bShouldWeDropValues = false;
    mOperationType = NONE_OPERATION_TYPE;
}
