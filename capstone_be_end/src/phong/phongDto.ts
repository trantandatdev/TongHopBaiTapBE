import { ApiProperty } from "@nestjs/swagger";

export class PhongDto {
    @ApiProperty()
    ten_phong: string;

    @ApiProperty()
    so_nguoi: number;

    @ApiProperty()
    phong_ngu: number

    @ApiProperty()
    giuong: number

    @ApiProperty()
    phong_tam: number

    @ApiProperty()
    mo_ta: string

    @ApiProperty()
    gia_tien: number

    @ApiProperty()
    may_giat: boolean

    @ApiProperty()
    ban_la: boolean

    @ApiProperty()
    tivi: boolean

    @ApiProperty()
    dieu_hoa: boolean

    @ApiProperty()
    wifi: boolean

    @ApiProperty()
    do_xe: boolean

    @ApiProperty()
    ho_boi: boolean

    @ApiProperty()
    ban_ui: boolean

    @ApiProperty()
    ma_vi_tri: number

    @ApiProperty({ nullable: true, })
    hinh_anh?: string | null
}

export class PhongImgDto {
    @ApiProperty({ type: 'array', items: { type: 'string', format: 'binary' } })
    files: any;
}