class Empleado
    attr_accessor :nombre, :apellido, :fecha_de_ingreso, :salario

    def initialize(nombre, apellido, fecha_de_ingreso, salario)
        @nombre = nombre
        @apellido = apellido
        @fecha_de_ingreso = fecha_de_ingreso
        @salario = salario
    end
    # metodos
    # Me retorna sueldo
    def calculo_de_sueldo(attr={})
        retencion = @salario * 0.1
        salud = @salario * 0.07
        pension = @salario * 0.12
        sueldo = @salario - retencion - salud - pension
    end
end

class Vendedor < Empleado
    attr_accessor :metas_de_apertura
    def initialize(nombre, apellido, fecha_de_ingreso, salario, metas_de_apertura)
        super(nombre, apellido, fecha_de_ingreso, salario)
        @metas_de_apertura = metas_de_apertura
    end

    # Calculo de comisiones
    def calculo_de_comisiones(numero_cuentas)
        if numero_cuentas > metas_de_apertura
            comision = numero_cuentas * 0.12
        else
            comision = numero_cuentas * 0.1
        end
        comision
    end

    def calculo_de_sueldo(attr)
        sueldo = super
        comision = calculo_de_comisiones(attr[:numero_de_cuentas])
        sueldo_total = sueldo + comision
    end
end


class Gerente < Empleado
    attr_accessor :metas_de_clientes
    def initialize(nombre, apellido, fecha_de_ingreso, salario, metas_de_clientes)
        super(nombre, apellido, fecha_de_ingreso, salario)
        @metas_de_clientes = metas_de_clientes
    end

    def calculo_de_participacion(numero_de_clientes)
        total_participacion = 0
        if numero_de_clientes > @metas_de_clientes
            total_participacion = numero_de_clientes / 100 * 0.01
        end
        total_participacion
    end

    def calculo_de_sueldo(attr)
        sueldo = super
        participacion = calculo_de_participacion(attr[:numero_de_clientes])
        sueldo_total = sueldo * (1 + participacion)  
    end
end


empleado = Empleado.new("ricardo", "montenegro", Time.now, 2000000)
empleado2 = Gerente.new("roberto", "daza", Time.now, 3000000, 1000)
empleado3 = Gerente.new("marcelo", "sagredo", Time.now, 4000000, 1200)
participacion = empleado2.calculo_de_participacion(1200)
participacion2 = empleado3.calculo_de_participacion(2000)
puts "La participacion en la empresa del gerente #{empleado2.nombre} es : #{participacion}"
puts "La participacion en la empresa del gerente #{empleado3.nombre} es : #{participacion2}"

empleado4 = Vendedor.new("raul", "bisquett", Time.now, 100000, 100)
sueldo1 = empleado.calculo_de_sueldo()
sueldo2 = empleado4.calculo_de_sueldo(numero_de_cuentas: 120)
sueldo3 = empleado3.calculo_de_sueldo(numero_de_clientes: 1000)
puts "El sueldo de el empleado #{empleado.nombre} es: #{sueldo1}"
puts "El sueldo de el empleado #{empleado4.nombre} es: #{sueldo2}"
puts "El sueldo de el empleado #{empleado3.nombre} es: #{sueldo3}"