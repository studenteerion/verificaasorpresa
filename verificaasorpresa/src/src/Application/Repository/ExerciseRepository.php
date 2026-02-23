<?php

declare(strict_types=1);

namespace App\Application\Repository;

use InvalidArgumentException;
use PDO;

final class ExerciseRepository
{
    private const DESCRIPTIONS = [
        1 => 'Pezzi per cui esiste almeno un fornitore',
        2 => 'Fornitori che forniscono ogni pezzo',
        3 => 'Fornitori che forniscono tutti i pezzi rossi',
        4 => 'Pezzi forniti da Acme e da nessun altro',
        5 => 'Fornitori che hanno costo superiore alla media per almeno un pezzo',
        6 => 'Per ciascun pezzo, fornitore/i con costo massimo',
        7 => 'Fornitori che forniscono solo pezzi rossi',
        8 => 'Fornitori con almeno un pezzo rosso e uno verde',
        9 => 'Fornitori con almeno un pezzo rosso o verde',
        10 => 'Pezzi forniti da almeno due fornitori',
    ];

    private const QUERIES = [
        1 => "
            SELECT DISTINCT p.pnome
            FROM Pezzi p
            JOIN Catalogo c ON c.pid = p.pid
            ORDER BY p.pnome
        ",

        2 => "
            SELECT f.fnome
            FROM Fornitori f
            WHERE NOT EXISTS (
                SELECT 1
                FROM Pezzi p
                WHERE NOT EXISTS (
                    SELECT 1
                    FROM Catalogo c
                    WHERE c.fid = f.fid AND c.pid = p.pid
                )
            )
            ORDER BY f.fnome
        ",

        3 => "
            SELECT f.fnome
            FROM Fornitori f
            WHERE NOT EXISTS (
                SELECT 1
                FROM Pezzi p
                WHERE p.colore = 'rosso'
                AND NOT EXISTS (
                    SELECT 1
                    FROM Catalogo c
                    WHERE c.fid = f.fid AND c.pid = p.pid
                )
            )
            ORDER BY f.fnome
        ",

        4 => "
            SELECT p.pnome
            FROM Pezzi p
            WHERE EXISTS (
                SELECT 1
                FROM Catalogo c
                JOIN Fornitori f ON f.fid = c.fid
                WHERE c.pid = p.pid AND f.fnome = 'Acme'
            )
            AND NOT EXISTS (
                SELECT 1
                FROM Catalogo c2
                JOIN Fornitori f2 ON f2.fid = c2.fid
                WHERE c2.pid = p.pid AND f2.fnome <> 'Acme'
            )
            ORDER BY p.pnome
        ",

        5 => "
            SELECT DISTINCT c.fid
            FROM Catalogo c
            WHERE c.costo > (
                SELECT AVG(c2.costo)
                FROM Catalogo c2
                WHERE c2.pid = c.pid
            )
            ORDER BY c.fid
        ",

        6 => "
            SELECT p.pnome, f.fnome
            FROM Catalogo c
            JOIN (
                SELECT pid, MAX(costo) AS max_costo
                FROM Catalogo
                GROUP BY pid
            ) m ON m.pid = c.pid AND m.max_costo = c.costo
            JOIN Pezzi p ON p.pid = c.pid
            JOIN Fornitori f ON f.fid = c.fid
            ORDER BY p.pnome, f.fnome
        ",

        7 => "
            SELECT f.fid
            FROM Fornitori f
            WHERE EXISTS (
                SELECT 1
                FROM Catalogo c
                WHERE c.fid = f.fid
            )
            AND NOT EXISTS (
                SELECT 1
                FROM Catalogo c
                JOIN Pezzi p ON p.pid = c.pid
                WHERE c.fid = f.fid AND p.colore <> 'rosso'
            )
            ORDER BY f.fid
        ",

        8 => "
            SELECT f.fid
            FROM Fornitori f
            WHERE EXISTS (
                SELECT 1
                FROM Catalogo c
                JOIN Pezzi p ON p.pid = c.pid
                WHERE c.fid = f.fid AND p.colore = 'rosso'
            )
            AND EXISTS (
                SELECT 1
                FROM Catalogo c
                JOIN Pezzi p ON p.pid = c.pid
                WHERE c.fid = f.fid AND p.colore = 'verde'
            )
            ORDER BY f.fid
        ",

        9 => "
            SELECT DISTINCT f.fid
            FROM Fornitori f
            JOIN Catalogo c ON c.fid = f.fid
            JOIN Pezzi p ON p.pid = c.pid
            WHERE p.colore IN ('rosso', 'verde')
            ORDER BY f.fid
        ",

        10 => "
            SELECT c.pid
            FROM Catalogo c
            GROUP BY c.pid
            HAVING COUNT(DISTINCT c.fid) >= 2
            ORDER BY c.pid
        "
    ];

    public function __construct(private PDO $pdo)
    {
    }

    /** @return array<int, array{id:int,description:string}> */
    public function listQueries(): array
    {
        $items = [];

        foreach (self::DESCRIPTIONS as $id => $description) {
            $items[] = [
                'id' => $id,
                'description' => $description,
            ];
        }

        return $items;
    }

    /** @return array{query:string,rows:array<int,array<string,mixed>>} */
    public function runQuery(int $id): array
    {
        $query = self::QUERIES[$id] ?? null;

        if ($query === null) {
            throw new InvalidArgumentException('Query non valida. Usa un id da 1 a 10.');
        }

        $statement = $this->pdo->query($query);
        $rows = $statement->fetchAll();

        return [
            'rows' => $rows,
        ];
    }
}
