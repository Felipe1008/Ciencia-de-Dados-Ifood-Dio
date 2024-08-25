LIMITE_SAQUES = 3;
quantidade_saques = 0;
conta = 0; 
extrato = "";

def Depositar(valor, saldo):
    if valor > 0: 
        saldo += valor;
    else:
        print("Valor inválido. Digite um valor positivo maior que 0.")
    return saldo;

def Sacar (valor, saldo):
    global quantidade_saques
    if saldo == 0:
        print("Sem saldo na conta.");
        return saldo, False
    if saldo > valor:
        if(valor <= 500 and valor > 0):
            saldo -= valor;
            quantidade_saques += 1;
            return saldo, True;
        else:
            print("Não foi possível realizar o saque. Digite um valor válido. OBS: Saque máximo de R$500,00");
            return saldo, False;
    else:
        print("Saldo insuficiente!");
        return saldo, False;
    
def Extrato(saldo, descricao):
    print("===== Movimentações =====\n")
    print(descricao);
    print("="*25);
    print(f"Saldo: R${saldo:.2f}\n");

def Menu():
    print(
        '''
        ====== MENU ======
            1 - Depositar
            2 - Sacar
            3- Extrato
            0 - Sair
        ==================
        '''
    )

while True:
    Menu();
    operacao = int(input("Escolha uma operação: "));
    if operacao == 1:
        valor_deposito = float(input("Digite o valor que quer depositar: "));
        conta = Depositar(valor_deposito, conta);
        extrato += f"Depósito de RS{valor_deposito:.2f}\n"
    elif operacao == 2:
        if quantidade_saques < LIMITE_SAQUES:
            valor_saque = float(input("Digite o valor que quer sacar: "));
            conta, sucesso = Sacar(valor_saque, conta);
            print("Número de saques realizados hoje:", quantidade_saques)
            if sucesso:
                extrato += f"Saque de RS{valor_saque:.2f}\n"
        else:
            print("Você já atingiu o máximo de 3 saques diários!")
    elif operacao == 3:
            Extrato(conta, extrato);
    elif operacao == 0:
        print("Obrigado por utilizar nossos serviços! Volte sempre!")
        break;
    else:
        print("Escolha uma operação válida!");


    