import 'package:flutter/material.dart';
import 'package:flutter_alquiler_autos_frontend_v26/themes/app_colors.dart';

class MedioPagoScreen extends StatelessWidget {
  MedioPagoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fondo,
      appBar: AppBar(
        backgroundColor: AppColors.encabezado,
        elevation: 0,
        title: Text(
          "Medio de Pago",
          style: TextStyle(
            color: AppColors.texto,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: IconThemeData(color: AppColors.texto),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          children: [
            Container(
              color: AppColors.campos,
              child: ListTile(
                leading: Icon(Icons.credit_card, color: AppColors.boton),
                title: Text(
                  "Tarjeta de Crédito o Débito",
                  style: TextStyle(
                    color: AppColors.texto,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {},
              ),
            ),
            Divider(color: AppColors.texto.withOpacity(0.2), height: 1),
            ListTile(
              leading: Icon(Icons.account_balance_wallet, color: AppColors.boton),
              title: Text(
                "PayPal",
                style: TextStyle(
                  color: AppColors.texto,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {},
            ),
            Divider(color: AppColors.texto.withOpacity(0.2), height: 1),
            ListTile(
              leading: Icon(Icons.account_balance, color: AppColors.boton),
              title: Text(
                "Transferencia Bancaria",
                style: TextStyle(
                  color: AppColors.texto,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}