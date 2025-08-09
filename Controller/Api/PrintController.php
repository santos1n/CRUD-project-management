<?php

// load composer autoloader for fpdgf
require_once dirname(dirname(__DIR__)) . '/vendor/autoload.php';

class PrintController extends AppController
{
    // Models
    public $uses = ['Crud', 'CrudBeneficiary', 'CrudStatus'];

    public function printTable()
    {
        // Allow post
        if (!$this->request->is('post')) {
            throw new MethodNotAllowedException();
        }

        // data neeeded
        if (empty($this->request->data['table_data'])) {
            throw new BadRequestException('No data provided');
        }

        // json table to php array
        $data = json_decode($this->request->data['table_data'], true);

        // only visible datas
        $visibleData = array_filter($data, function ($row) {
            return isset($row['visible']) && ($row['visible'] == true || $row['visible'] === "1");
        });

        // headers
        header('Content-Type: application/pdf');
        header('Content-Disposition: inline; filename="table.pdf"');

        // create new document
        $pdf = new \FPDF();
        $pdf->AddPage();

        // Title
        $pdf->SetFont('Arial', 'B', 14);
        $pdf->Cell(0, 10, 'DATA TABLE', 0, 1, 'C');
        $pdf->Ln(5);

        // columns and alignment
        $col1Width = 20;
        $col2Width = 60;
        $tableWidth = $col1Width + ($col2Width * 2);
        $startX = ($pdf->GetPageWidth() - $tableWidth) / 2;

        // Table header
        $pdf->SetFont('Arial', 'B', 9);
        $pdf->SetX($startX);
        $pdf->Cell($col1Width, 10, '#', 1);
        $pdf->Cell($col2Width, 10, 'Name', 1);
        $pdf->Cell($col2Width, 10, 'Status', 1);
        $pdf->Ln();

        // Table rows
        $pdf->SetFont('Arial', '', 7);
        $i = 1;
        foreach ($visibleData as $row) {
            $pdf->SetX($startX);

            // Map status code to text
            $statusText = 'Unknown';
            if (isset($row['status'])) {
                switch ($row['status']) {
                    case 'PENDING':
                        $statusText = 'Pending';
                        break;
                    case 'APPROVED':
                        $statusText = 'Approved';
                        break;
                    case 'DISAPPROVED':
                        $statusText = 'Disapproved';
                        break;
                }
            }

            // fill table row
            $pdf->Cell($col1Width, 10, $i++, 1);
            $pdf->Cell($col2Width, 10, $row['name'] ?? '', 1);
            $pdf->Cell($col2Width, 10, $statusText, 1);
            $pdf->Ln();
        }

        // output pdf
        $pdf->Output();
        exit;
    }

    public function printProfile()
    {
        if (!$this->request->is('post')) {
            throw new MethodNotAllowedException();
        }

        if (empty($this->request->data['profile_data'])) {
            throw new BadRequestException('No data provided');
        }

        $data = json_decode($this->request->data['profile_data'], true);
        $crud = $data['Crud'] ?? [];
        $status = $data['CrudStatus']['name'] ?? 'N/A';
        $beneficiaries = $data['Beneficiary'] ?? [];

        // header
        header('Content-Type: application/pdf');
        header('Content-Disposition: inline; filename="profile.pdf"');

        // new pdf file
        $pdf = new \FPDF();
        $pdf->AddPage();

        // Title centered
        $pdf->SetFont('Arial', 'B', 16);
        $pdf->Cell(0, 10, 'Profile View', 0, 1, 'C');
        $pdf->Ln(5);

        $pdf->SetFont('Arial', '', 12);

        // center layout
        $labelWidth = 40;
        $valueWidth = 100;
        $totalWidth = $labelWidth + $valueWidth;
        $startX = ($pdf->GetPageWidth() - $totalWidth) / 2;

        // print fileds
        $pdf->SetX($startX);
        $pdf->Cell($labelWidth, 10, 'Name:', 0, 0);
        $pdf->Cell($valueWidth, 10, strtoupper($crud['name'] ?? ''), 0, 1);

        $pdf->SetX($startX);
        $pdf->Cell($labelWidth, 10, 'Age:', 0, 0);
        $pdf->Cell($valueWidth, 10, $crud['age'] ?? '', 0, 1);

        $pdf->SetX($startX);
        $pdf->Cell($labelWidth, 10, 'Status:', 0, 0);
        $pdf->Cell($valueWidth, 10, $status, 0, 1);

        $pdf->SetX($startX);
        $pdf->Cell($labelWidth, 10, 'Birthday:', 0, 0);
        $pdf->Cell($valueWidth, 10, $crud['birthdate'] ?? '', 0, 1);

        $pdf->SetX($startX);
        $pdf->Cell($labelWidth, 10, 'Character:', 0, 0);
        $pdf->Cell($valueWidth, 10, $crud['character'] ?? '', 0, 1);

        $pdf->SetX($startX);
        $pdf->Cell($labelWidth, 10, 'Email:', 0, 0);
        $pdf->Cell($valueWidth, 10, $crud['email'] ?? '', 0, 1);

        $pdf->Ln(5);

        // headers
        $pdf->SetFont('Arial', 'B', 14);
        $pdf->Cell(0, 10, 'Beneficiaries', 0, 1, 'C');
        $pdf->Ln(3);

        // table dimensions
        $col1 = 10; // #
        $col2 = 60; // Name
        $col3 = 40; // Age
        $col4 = 40; // Birthday
        $tableWidth = $col1 + $col2 + $col3 + $col4;
        $tableX = ($pdf->GetPageWidth() - $tableWidth) / 2;

        $pdf->SetFont('Arial', 'B', 12);
        $pdf->SetX($tableX);
        $pdf->Cell($col1, 10, '#', 1, 0, 'C');
        $pdf->Cell($col2, 10, 'Name', 1, 0, 'C');
        $pdf->Cell($col3, 10, 'Age', 1, 0, 'C');
        $pdf->Cell($col4, 10, 'Birthday', 1, 1, 'C');

        $pdf->SetFont('Arial', '', 12);

        // message for no data
        if (empty($beneficiaries)) {
            $pdf->SetX($tableX);
            $pdf->Cell($tableWidth, 10, 'No data available', 1, 1, 'C');
        } else {
            foreach ($beneficiaries as $i => $b) {
                $pdf->SetX($tableX);
                $pdf->Cell($col1, 10, $i + 1, 1, 0, 'C');
                $pdf->Cell($col2, 10, $b['name'] ?? '', 1, 0);
                $pdf->Cell($col3, 10, $b['age'] ?? '', 1, 0, 'C');
                $pdf->Cell($col4, 10, $b['birthday'] ?? '', 1, 1);
            }
        }

        // output pdf
        $pdf->Output();
        exit;
    }
}
