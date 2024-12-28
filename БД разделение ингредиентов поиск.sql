-- SQLite
-- Добавляем новый столбец
ALTER TABLE content ADD COLUMN ingredients TEXT;

-- Переносим данные
UPDATE content
SET ingredients = SUBSTR(contenttext, INSTR(contenttext, 'Ингредиенты:'), INSTR(contenttext, 'Шаги:') - INSTR(contenttext, 'Ингредиенты:'))
WHERE contenttext LIKE '%Ингредиенты:%';