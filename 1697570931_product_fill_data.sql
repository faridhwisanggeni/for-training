-- +migrate Up
-- SQL in section 'Up' is executed when this migration is applied
-- [your SQL script here]
INSERT INTO public.product
(id, product_name, basic_price, stock, created_date, created_by, updated_date, updated_by)
VALUES('5d45c767-7219-4a3d-8440-c8dad4e43fc5'::uuid, 'Varsity Jacket Bandung', 150000, 200, '2024-01-14 00:00:00.000', 'FARIDH', NULL, NULL);
INSERT INTO public.product
(id, product_name, basic_price, stock, created_date, created_by, updated_date, updated_by)
VALUES('1a2ab6b3-c0ab-4d9e-9a9e-63d1bc1791dc'::uuid, 'Varsity Jacket Medan', 155000, 100, '2024-01-14 00:00:00.000', 'FARIDH', NULL, NULL);
INSERT INTO public.product
(id, product_name, basic_price, stock, created_date, created_by, updated_date, updated_by)
VALUES('e28be10a-0c13-446a-955b-8ced39d44056'::uuid, 'Varsity Jacket Surabaya', 152000, 10, '2024-01-14 00:00:00.000', 'FARIDH', NULL, NULL);
INSERT INTO public.product
(id, product_name, basic_price, stock, created_date, created_by, updated_date, updated_by)
VALUES('962449df-fea7-4fdb-865b-7db12952da19'::uuid, 'Bomber Jacket F16', 180000, 110, '2024-01-14 00:00:00.000', 'FARIDH', NULL, NULL);
INSERT INTO public.product
(id, product_name, basic_price, stock, created_date, created_by, updated_date, updated_by)
VALUES('3c1cad99-f6d6-46d4-aef4-472f93f89c0e'::uuid, 'Bomber Jacket Sukhoi', 320000, 1100, '2024-01-14 00:00:00.000', 'FARIDH', NULL, NULL);
INSERT INTO public.product
(id, product_name, basic_price, stock, created_date, created_by, updated_date, updated_by)
VALUES('a409c14a-841f-41dd-92ff-06e859f3119f'::uuid, 'Bomber Jacket Sukhoi 34', 670000, 100, '2024-01-14 00:00:00.000', 'FARIDH', NULL, NULL);


-- +migrate Down
-- SQL section 'Down' is executed when this migration is rolled back
-- [your SQL script here]
DELETE FROM public.product
WHERE id='5d45c767-7219-4a3d-8440-c8dad4e43fc5'::uuid;
DELETE FROM public.product
WHERE id='1a2ab6b3-c0ab-4d9e-9a9e-63d1bc1791dc'::uuid;
DELETE FROM public.product
WHERE id='e28be10a-0c13-446a-955b-8ced39d44056'::uuid;
DELETE FROM public.product
WHERE id='962449df-fea7-4fdb-865b-7db12952da19'::uuid;
DELETE FROM public.product
WHERE id='3c1cad99-f6d6-46d4-aef4-472f93f89c0e'::uuid;
DELETE FROM public.product
WHERE id='a409c14a-841f-41dd-92ff-06e859f3119f'::uuid;
