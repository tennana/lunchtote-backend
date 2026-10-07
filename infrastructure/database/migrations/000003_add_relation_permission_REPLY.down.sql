ALTER TYPE relation_permission RENAME TO relation_permission_old;
CREATE TYPE relation_permission AS ENUM (
    'DISALLOW',
    'FOLLOW',
    'FOLLOWED',
    'MUTUAL_FOLLOW',
    'ALL'
    );

UPDATE characters SET book_permission = 'DISALLOW' WHERE book_permission = 'REPLY';
UPDATE rooms_messages SET reply_permission = 'DISALLOW' WHERE reply_permission = 'REPLY';

ALTER TABLE characters
    ALTER COLUMN book_permission DROP DEFAULT,
    ALTER COLUMN book_permission TYPE relation_permission USING book_permission::text::relation_permission,
    ALTER COLUMN book_permission SET DEFAULT 'ALL';
ALTER TABLE rooms_messages
    ALTER COLUMN reply_permission DROP DEFAULT,
    ALTER COLUMN reply_permission TYPE relation_permission USING reply_permission::text::relation_permission,
    ALTER COLUMN reply_permission SET DEFAULT 'ALL';

DROP TYPE relation_permission_old;
